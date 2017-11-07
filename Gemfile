# coding: utf-8
source 'https://rubygems.org'

# For confining local variables to a small scope, see:
#   http://stackoverflow.com/a/27469713/1136063

def scope() yield end

# For specifying the bundler gem's version, see:
#   http://stackoverflow.com/a/18384158/1136063

scope do
  bundler_version_minimum = '1.16.1'
  ::Kernel.abort "Bundler version at least #{bundler_version_minimum} is required" if\
      (::Gem::Version.new ::Bundler::VERSION) <
      (::Gem::Version.new                    bundler_version_minimum)
end

scope do
  dirname_file_current = ::Kernel.__dir__
  project_root = dirname_file_current
  filename = ::File.realpath '.ruby-version', project_root
  ruby_version_required = ::File.open(filename, 'r'){|f| f.first.chomp}
  with_operator = ruby_version_required.prepend '='
  ruby                with_operator,
      engine_version: with_operator,
      engine:        'ruby',
      patchlevel:    '319'
end

# Specify gem dependencies in {anything}.gemspec.
gemspec

group :development, :test do
  gem 'rake', '12.3.0'
end

group :test do
  gem 'minitest', '5.4.3'
end
