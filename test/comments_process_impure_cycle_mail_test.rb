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
#require_relative 'comments_process_impure_email_send_test_module_methods'
require 'cycle_mail_module_methods'
require 'email_send_module_methods'
require 'my_file_module_methods'

module ::QplaylistRememberCommentsProcess
  class CommentsProcessImpureCycleMailTest < QplaylistRememberCommentsProcessTest
    module InstanceMethods

      include TestHelperMethods::InstanceMethods

      def setup
        model_clear
        nil
      end

      def test_all
        mock = ::Minitest::Mock.new
        mock.expect :call, nil, [
            email_expected,
#           'email-daemon@example.com',
#           'email-reply-to-daemon@example.com',
#           'email-daemon-password',
            ]
        stub_things do
          ::QplaylistRememberCommentsProcess::CommentsProcess::Impure::EmailSend.stub :connect_and_send, mock do
##assert_raises SystemExit do
            file_clear filename_output_log
            code_to_be_tested do
              model[:schedule_source] = filename_schedule_source
            end
#print '@address_test='; pp @address_test
#           assert_connect_and_send
#           assert_equal_file_content expected_filename_output_log, filename_output_log
##end
          end
        end
#       assert mock.verify
        nil
      end

      private

#     def assert_connect_and_send
#       assert_equal 'email-daemon@example.com', CommentsProcess::Impure::EmailSend. address_test
#       assert_equal 'email-daemon-password',    CommentsProcess::Impure::EmailSend.password_test

#       assert_equal 'email-daemon@example.com', CommentsProcess::Impure::EmailSend.instance_variable_get(:@address_test)
#       assert_equal 'email-daemon-password',    CommentsProcess::Impure::EmailSend.instance_variable_get(:@password_test)
#       assert_equal 'email-daemon@example.com', @address_test
#       assert_equal 'zzemail-daemon@example.com', @address_reply_to_test
#       assert_equal 'email-daemon-password',    @password_test
#       assert_equal email_expected, email_actual
#       nil
#     end

      def code_to_be_tested
        CommentsProcess::Impure::CycleMail.init
        yield if block_given?
        CommentsProcess::Impure::CycleMail.run
        nil
      end

#     def connect_and_send_arguments
#     end

#     def connect_and_send_old(*args)
#       names_ordered = %w[
#           email
#           address
#           address_reply_to
#           password
#           ]
#       names_ordered.zip(args).each do |name,        arg|
#         instance_variable_set     :"@#{name}_test", arg
#       end
#       @email_test, @address_test, @address_reply_to_test, @password_test = args
#     end

      def email_actual
#       CommentsProcess::Impure::EmailSend.email_test.inspect
        CommentsProcess::Impure::EmailSend.instance_variable_get(:@email_test).inspect
#       @email_test.inspect
      end

      def email_expected
        filename = filename_fixture 'email.txt'
        ::File.open filename, 'r' do |f|
          return f.read
        end
      end

      def expected_filename_output_log
        filename_fixture 'log.txt'
      end

      def filename_comments
        filename_fixture 'comments.txt'
      end

      def program_prefix
        'mail'
      end

      def stub_things
        ::          QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :filename_comments,         filename_comments                 do
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
        end
        nil
      end
    end
  end
end
