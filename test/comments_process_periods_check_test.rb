# coding: utf-8

require_relative 'test_helper'
require_relative 'test_helper_methods'
require_relative '../lib/comments_process/pure/my_file'

module ::QplaylistRememberCommentsProcessTest
  class CommentsProcessPeriodsCheckTest < ::Minitest::Test

    include TestHelperMethods

    def setup
      model_clear
      nil
    end

    def test_no_periods_match
      ::CommentsProcess::Pure::MyFile.stub :filename_environment_file, filename_environment_no_match do
        stub_things do
          file_touch filename_output_log
          exception = assert_raises SystemExit do
            load_and_run_the_code_to_be_tested
          end
          no_periods_match = 3
          assert_equal no_periods_match, exception.status
        end
      end
      nil
    end

    def test_rest
      ::CommentsProcess::Pure::MyFile.stub :filename_environment_file, filename_environment_file do
        stub_things do
          file_touch filename_output_log # The code under test doesn't necessarily create the log file.
          load_and_run_the_code_to_be_tested
          assert_equal_file_content expected_filename_output_log, filename_output_log
        end
      end
      nil
    end

    private

    def expected_filename_output_log
      filename_fixture 'log.txt'
    end

    def filename_environment_file
      filename_fixture 'environment-file.txt'
    end

    def filename_environment_no_match
      filename_fixture 'environment-file-no-periods-match.txt'
    end

    def load_and_run_the_code_to_be_tested
      ::Kernel.load "#{__dir__}/../lib/comments_process_periods_check.rb"
      nil
    end

    def program_prefix
      'periods_check'
    end

    def stub_things
      ::        CommentsProcess::Pure::MyFile.stub :filename_log,             filename_output_log           do
        ::      CommentsProcess::Pure::MyFile.stub :folder_data_applications, folder_data_applications      do
          ::    CommentsProcess::Pure::MyFile.stub :folder_data_own,          folder_data_own               do
            ::  Time.stub                          :now,                      time_now                      do
              yield
            end
          end
        end
      end
      nil
    end
  end
end
