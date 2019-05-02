# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require_relative 'command_line_test_helper'
require_relative '../../etc/qplaylist-remember-comments-process-clear_methods'

module ::QplaylistRememberCommentsProcess
  module CommandLine
    class QplaylistRememberCommentsProcessClearTest < QplaylistRememberCommentsProcessCommandLineTest

      include ::QplaylistRememberCommentsProcess::CommandLine::TestHelperMethods::InstanceMethods

      def test_altered_for_testing
        ::      QplaylistRememberCommentsProcess::CommandLine.stub :command_run,                     command_run                     do
          ::    QplaylistRememberCommentsProcess::CommandLine.stub :confirm_ftp_command_file_exists, confirm_ftp_command_file_exists do
            ::  QplaylistRememberCommentsProcess::CommandLine.stub :greeting_at_opening,             greeting_at_opening             do
              ::QplaylistRememberCommentsProcess::CommandLine.stub :altered_for_testing,             altered_for_testing_mock        do
                ::Kernel.load filename
              end
            end
          end
        end
        altered_for_testing_mock.verify
      end

      def test_command_run
        ::  QplaylistRememberCommentsProcess::CommandLine.stub :altered_for_testing, altered_for_testing do
          ::QplaylistRememberCommentsProcess::CommandLine.stub :command_run,         command_run_mock    do
            ::Kernel.load filename
          end
        end
        command_run_mock.verify
      end

      private

      def altered_for_testing
        'some-string'
      end

      def altered_for_testing_mock
        @altered_for_testing_mock_value ||= begin
          return_value = altered_for_testing
          params = []
          ::Minitest::Mock.new.expect :call, return_value, params
        end
      end

      def basename
        'qplaylist-remember-comments-process-clear'
      end

      def command_run
        nil
      end

      def command_run_mock
        @command_run_mock_value ||= begin
          return_value = nil
          parameter_first = ['ftp', altered_for_testing]
          params = [parameter_first]
          ::Minitest::Mock.new.expect :call, return_value, params
        end
      end

      def confirm_ftp_command_file_exists
        true
      end

      def filename
        ::File.expand_path basename, directory_exe
      end

      def greeting_at_opening
        nil
      end
    end
  end
end
