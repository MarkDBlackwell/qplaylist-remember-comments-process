# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require_relative 'test_helper'
require_relative 'test_helper_methods_instance_methods'
require 'cycle_periods_check_module_methods'
require 'my_file_module_methods'

module ::QplaylistRememberCommentsProcess
  class CommentsProcessImpureCyclePeriodsCheckTest < ::Minitest::Test
    module InstanceMethods

      include TestHelperMethods::InstanceMethods

      def setup
        model_clear
        nil
      end

      def test_no_periods_match
        stub_things do
          file_touch filename_output_log
          exception = assert_raises SystemExit do
            code_to_be_tested do
              model[:schedule_source] = filename_schedule_source_no_match
            end
          end
          no_periods_match = 3
          assert_equal no_periods_match, exception.status
        end
        nil
      end

      def test_rest
        stub_things do
          file_touch filename_output_log # The code under test doesn't necessarily create the log file.
          code_to_be_tested do
            model[:schedule_source] = filename_schedule_source
          end
          assert_equal_file_content expected_filename_output_log, filename_output_log
        end
        nil
      end

      private

      def code_to_be_tested
        CommentsProcess::Impure::CyclePeriodsCheck.init
        yield if block_given?
        CommentsProcess::Impure::CyclePeriodsCheck.run
        nil
      end

      def filename_schedule_source_no_match
        filename_fixture 'RememberSongsScheduleNoMatch.txt'
      end

      def program_prefix
        'periods_check'
      end

      def stub_things
        ::        QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :filename_environment_file, filename_environment_file_fixture do
          ::      QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :filename_log,              filename_output_log               do
            ::    QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :folder_data_applications,  folder_data_applications          do
              ::  QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :folder_data_own,           folder_data_own                   do
                ::Time.stub                                                            :now,                       time_now                          do
                  yield
                end
              end
            end
          end
        end
        nil
      end
    end
  end
end
