# coding: utf-8

require_relative 'test_helper_methods'
require_relative 'comments_process_impure_email_send_class_methods'
require 'cycle_mail'
require 'email_send'
require 'my_file'

module ::QplaylistRememberCommentsProcess
  class CommentsProcessImpureCycleMailTest < QplaylistRememberCommentsProcessTest
    module InstanceMethods

      include TestHelperMethods

      def setup
        model_clear
        nil
      end

      def test_all
        stub_things do
##assert_raises SystemExit do
          file_clear filename_output_log
          code_to_be_tested do
            model[:schedule_source] = filename_schedule_source
          end
          assert_connect_and_send
          assert_equal_file_content expected_filename_output_log, filename_output_log
##end
        end
        nil
      end

      private

      def assert_connect_and_send
        assert_equal 'email-daemon@example.com', CommentsProcess::Impure::EmailSend. address_test
        assert_equal 'email-daemon-password',    CommentsProcess::Impure::EmailSend.password_test
        assert_equal expected_email, actual_email
        nil
      end

      def actual_email
        CommentsProcess::Impure::EmailSend.email_test.inspect
      end

      def code_to_be_tested
        CommentsProcess::Impure::CycleMail.init
        yield if block_given?
        CommentsProcess::Impure::CycleMail.run
        nil
      end

      def expected_email
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
