# coding: utf-8

desc "The default is 'test'"
task default: :test

# desc 'gem'
# task :gem do
#   require 'bundler/gem_tasks'
# # Do something
# end

desc 'Run all tests'
# To pass options to Minitest:
#   ruby -vw test/comments_process_periods_check_test.rb --seed 62879
#
task test: :'test:clean' do
  require 'rake/testtask'
  Rake::TestTask.new :test do |t|
    t.test_files = FileList.new 'test/**/*_test.rb'
    t.verbose = true
    t.warning = true
  end
end

namespace :test do
  desc 'Clean up all test artifacts'
  task clean: %i[ clean_own  clean_var ]

  desc "Clean up test artifacts under various 'own' directories"
  task :clean_own do
    delay_seconds = 0.1 # Time padding; allows Windows to finish removing files or directories.
    programs = %w[ mail  periods_check  set_up ]
    programs.each do |program|
      dirname_own = "test/#{program}/appdata/.qplaylist-remember-comments-process"
      dirname_var = ::File.join dirname_own, 'var'
      glob_own = ::File.join dirname_own, '**'
      FileList.new(glob_own).each{|e| ::File.delete e unless ::File.directory? e}
      if %w[ mail  periods_check  set_up ].include? program
        ::Kernel.sleep delay_seconds
        ::Dir.rmdir dirname_var if ::Dir.exist? dirname_var
      end
      if %w[ set_up ].include? program
        ::Kernel.sleep delay_seconds
        ::Dir.rmdir dirname_own if ::Dir.exist? dirname_own
      end
    end
  end

  desc 'Clean up test artifacts under various var directories'
  task :clean_var do
    programs = %w[ mail  periods_check  set_up ]
    programs.each do |program|
      glob_var = "test/#{program}/var/**"
      FileList.new(glob_var).each{|e| ::File.delete e unless ::File.directory? e}
    end
  end
end
