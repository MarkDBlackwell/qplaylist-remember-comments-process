# coding: utf-8

=begin
Author: Mark D. Blackwell (google me)
mdb March 20, 2018 - created
=end

require 'English'

module ::Methods
  module InstanceMethods

    def child_status
      $CHILD_STATUS
    end

    def child_status_integer
      child_status.exitstatus if child_status
    end

    def command_ran_best
      exit_status_okay == child_status_integer
    end

    def command_run(array, is_tentative=false)
      ::Kernel.system *array
      message = "#{array} exit status was #{child_status}"
      unless command_ran_well_enough is_tentative
        print "#{message}\n\n"
        trace_write = true
        log_write message, trace_write
      end
      nil
    end

    def confirm_ftp_command_file_exists(filename)
      message = "FTP command file: #{filename} not found"
      filename_okay = (::File.file? filename) && (::File.readable? filename)
      unless filename_okay
        trace_write = true
        log_write message, trace_write
        ::Kernel.abort message
      end
    end

    def directory_etc
      ::File.join project_root, 'etc'
    end

    def directory_volatiles
      ::File.join appdata_subdirectory_own, 'var'
    end

    def filename_command_ftp(action)
      ::File.join appdata_subdirectory_own, "comments-#{action}.ftp"
    end

    def filename_program_mail
      ::File.join directory_lib, "#{name_package}_mail.rb"
    end

    def filename_program_periods_check
      ::File.join directory_lib, "#{name_package}_periods_check.rb"
    end

    def filename_program_set_up
      ::File.join directory_lib, "#{name_package}_set_up.rb"
    end

    def greeting_at_opening
      author = 'Mark D. Blackwell'
      email = 'markdblackwell01@gmail.com'
      program = ::File.split($PROGRAM_NAME).last
      year = '2018'
      message = "#{program}  " \
          "Copyright (C) #{year}  #{author} <#{email}>, " \
          "all rights reserved.\n" \
          "This program comes with ABSOLUTELY NO WARRANTY. " \
          "For details, see LICENSE.txt.\n"
      print message
      nil
    end

    def project_root
       @project_root_value ||= ::File.realpath '..', dirname_script_this
    end

    def scope
# Confine local variables to a small scope
# See:
#   http://stackoverflow.com/a/27469713/1136063
#-------------
      yield
    end

    private

    def appdata_subdirectory_own
      directory_appdata = ::File.realpath ::ENV['APPDATA']
      ::File.join directory_appdata, '.qplaylist-remember-comments-process'
    end

    def command_ran_well_enough(is_tentative)
      no_emails_sent    = is_tentative && exit_status_no_emails_sent    == child_status_integer
      no_period_matches = is_tentative && exit_status_no_period_matches == child_status_integer
      command_ran_best || no_emails_sent || no_period_matches
    end

    def directory_lib
      ::File.join project_root, 'lib'
    end

    def dirname_script_this
      ::Kernel.__dir__
    end

    def exit_status_no_emails_sent
      2
    end

    def exit_status_no_period_matches
      3
    end

    def exit_status_okay
      0
    end

    def filename_log
      ::File.join directory_volatiles, 'log.txt'
    end

    def log_write(s, trace_write=false)
      entries_omit_count = 3
      time = log_write_time
      message = "#{time} #{s}\n"
      ::File.open filename_log, 'a' do |f|
        f.print message
        if trace_write
          execution_stack = ::Kernel.caller entries_omit_count
          execution_stack.each{|e| f.print "#{time} #{e}\n"}
        end
      end
      nil
    end

    def log_write_time
## '^a' means upper-case weekday name:
      format = '%Y-%m-%d %^a %H:%M:%S'
      ::Time.now.strftime format
    end

    def name_package
      'comments_process'
    end
  end

  include ::Methods::InstanceMethods
end
