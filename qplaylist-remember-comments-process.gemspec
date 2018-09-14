# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

version = ::File.join(*%w[ lib  comments_process  pure  version])
require_relative version

# See: http://yehudakatz.com/2010/04/02/using-gemspecs-as-intended/

# By its very nature, this is a gem for "direct use". Unlike most gems, it:
#  1. Is standalone;
#  2. Shouldn't be a gem component for other projects;
#  3. Doesn't attempt to be flexible in its dependencies; and
#  4. Locks its requirements minutely and totally. (maybe)

gem_name = 'qplaylist-remember-comments-process'

::Gem::Specification.new do |s|
  s.author      = 'Mark D. Blackwell'
  s.bindir      = 'exe'
  s.description = <<-HERE.split.join ' '
        A Windows Ruby gem that processes
        listeners comments about recent songs
        and emails them to disk jockeys
        for any radio station
        which uses WideOrbit automation software.
        HERE
  s.email       = 'markdblackwell01@example.com'
  s.executables = ::Dir.glob('exe/**/*').map{|e| ::File.basename e}
  s.files += ::Dir.glob '.[^.]*' # Root dotfiles.
  s.files += ::Dir.glob 'Gemfile*' # Include Gemfile.lock.
  s.files += ::Dir.glob 'LICENSE.txt'
  s.files += ::Dir.glob 'README.md'
  s.files += ::Dir.glob '{data,etc,lib}/**/*'
  s.files += ::Dir.glob '*.gemspec'
  s.files -= ::Dir.glob '**/.gitkeep'
  s.files = s.files.sort
  s.homepage                      = 'https://will-be-on-GitHub.example.com'
  s.license                       = 'Nonstandard'
  s.metadata['allowed_push_host'] = 'https://rubygems.org'
  s.name                          = gem_name
  s.platform                      = ::Gem::Platform::RUBY
  s.post_install_message          = "#{gem_name} installation complete.\n" \
                                    "Next, do 'qplaylist-remember-comments-process-set-up'."
  s.rdoc_options                 << "--title #{gem_name}"
  s.rdoc_options                 += %w[--main README.md]
  s.require_paths                 = %w[lib]
  s.required_rubygems_version     = '>= 2.7.4'
  s.requirements                 << 'WideOrbit Automation'
  s.requirements                 << 'Windows NT family'
  s.requirements                 << 'Windows 7 (maybe)'
# s.rubygems_version # Don't set this: it's automatic.
  s.specification_version         = 1
  s.summary    = 'Process captured song comments'
  s.test_files = ::Dir.glob '{test,tests}/**/*'
  s.version    = ::QplaylistRememberCommentsProcess::CommentsProcess::Pure::VERSION

## Base-level dependencies:
##     bundler
##     gmail

# Dependencies:
  s.add_dependency 'bundler', '1.16.1'
  s.add_dependency 'gmail', '0.6.0'

# Per:
# https://github.com/bundler/bundler/issues/4131
# http://stackoverflow.com/questions/17717529/teamcity-rake-runner-incompatible-with-test-unit-2-0-0-0

# If we need a gem which is built-into Ruby, then:
#  1. Specify the latest version; and
#  2. Run `bundle install --no-cache`.

# Or, we can:
#  1. Download its .gem file from RubyGems.org;
#  2. Place that file in /vendor/cache/ (that is, if we're caching); and
#  3. Run `bundle install`.
end
