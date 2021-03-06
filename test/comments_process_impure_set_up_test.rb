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
require 'my_file_module_methods'
require 'set_up_module_methods'

module ::QplaylistRememberCommentsProcess
  class CommentsProcessImpureSetUpTest < QplaylistRememberCommentsProcessTest
    module InstanceMethods

      include TestHelperMethods::InstanceMethods

      def setup
        model_clear
        nil
      end

      def test_all
        stub_things do
          file_touch filename_output_log # The code under test doesn't necessarily create the log file.
          code_to_be_tested

          assert_equal_file_content expected_filename_comments_delete,  filename_comments_delete
          assert_equal_file_content expected_filename_comments_get,     filename_comments_get
          assert_equal_file_content filename_environment_file_fixture,  filename_environment_file
          assert_equal_file_content expected_filename_output_log,       filename_output_log

          assert_equal_filename_filehandle_content expected_filename_echo,   filehandle_output_echo
          assert_equal_filename_filehandle_content expected_filename_prompt, filehandle_output_prompt
        end
        nil
      end

      def teardown
        filehandle_input_user   .close
        filehandle_output_echo  .close
        filehandle_output_prompt.close
        nil
      end

      private

      def code_to_be_tested
        CommentsProcess::Impure::SetUp.init
        CommentsProcess::Impure::SetUp.run
        nil
      end

      def expected_filename_comments_delete
        filename_fixture 'comments-delete.ftp'
      end

      def expected_filename_comments_get
        filename_fixture 'comments-get.ftp'
      end

      def expected_filename_echo
        filename_fixture 'echo.txt'
      end

      def expected_filename_prompt
        filename_fixture 'prompt.txt'
      end

      def filehandle_input_user
         @filehandle_input_user_value ||= ::File.open filename_input_user, 'r'
      end

      def filehandle_output_echo
         @filehandle_output_echo_value ||= ::File.open filename_output_echo, 'w+'
      end

      def filehandle_output_prompt
         @filehandle_output_prompt_value ||= ::File.open filename_output_prompt, 'w+'
      end

      def filename_comments_delete
        ::File.join folder_data_applications, basename_own, 'comments-delete.ftp'
      end

      def filename_comments_get
        ::File.join folder_data_applications, basename_own, 'comments-get.ftp'
      end

      def filename_input_user
        filename_fixture 'input-user.txt'
      end

      def filename_output_echo
        filename_volatile 'echo.txt'
      end

      def filename_output_prompt
        filename_volatile 'prompt.txt'
      end

      def program_prefix
        'set_up'
      end

      def stub_things
        ::        QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :filehandle_echo,          filehandle_output_echo   do
          ::      QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :filehandle_input_user,    filehandle_input_user    do
            ::    QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :filehandle_prompt,        filehandle_output_prompt do
              ::  QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :filename_log,             filename_output_log      do
                ::QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :folder_data_applications, folder_data_applications do
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
