# coding: utf-8

require_relative 'test_helper'
require_relative 'test_helper_methods'
require_relative '../lib/comments_process/impure/email_send'
require_relative '../lib/comments_process/pure/my_file'

module ::CommentsProcess
  module Impure
    module EmailSend
      module ClassMethods

# Keep before attr_reader:
        def self.names_ordered_test
          %w[email address password].map{|e| :"#{e}_test"}
        end

        attr_reader(*names_ordered_test)

        def connect_and_send(*args)
          %w[email address password].zip(args).each do |name,        arg|
            instance_variable_set                  :"@#{name}_test", arg
          end
        end
      end
    end
  end
end

module ::QplaylistRememberCommentsProcessTest
  class CommentsProcessMailTest < CommentsProcessTest

    include TestHelperMethods

    def setup
      model_clear
      nil
    end

    def test_all
      stub_things do
        file_clear filename_output_log
        load_and_run_the_code_to_be_tested
        assert_connect_and_send
        assert_equal_file_content expected_filename_output_log, filename_output_log
      end
      nil
    end

    private

    def assert_connect_and_send
      assert_equal 'email-daemon@example.com', ::CommentsProcess::Impure::EmailSend. address_test
      assert_equal 'email-daemon-password',    ::CommentsProcess::Impure::EmailSend.password_test
      assert_equal expected_email, actual_email
      nil
    end

    def actual_email
      ::CommentsProcess::Impure::EmailSend.email_test.inspect
    end

    def expected_email
      <<HEREDOC
Juke
Tue 12 to 2 PM likes
juke@example.org
Dear Juke:
Here are the songs users especially liked from your show, aired on 2018-06-05:

6:48 PM Offa Rex (The Decembrists & Olivia Chaney): Bonny May
Loved it! (2)
gg; hh

6:49 PM Offa Rex (The Decembrists & Olivia Chaney): Bonny Maya
6:49 PM Offa Rex (The Decembrists & Olivia Chaney): Bonny Mayb
Loved it! (3)
dd
ee; ff; gg
hh; ii; jj

Sincerely,
The Remember Songs daemon
HEREDOC
    end

    def expected_filename_output_log
      filename_fixture 'log.txt'
    end

    def filename_comments
      filename_fixture 'comments.txt'
    end

    def filename_environment
      filename_fixture 'environment-file.txt'
    end

    def load_and_run_the_code_to_be_tested
      ::Kernel.load "#{__dir__}/../lib/comments_process_mail.rb"
      nil
    end

    def program_prefix
      'mail'
    end

    def stub_things
      ::            CommentsProcess::Pure::MyFile.stub :filename_comments,         filename_comments   do
        ::          CommentsProcess::Pure::MyFile.stub :filename_environment_file, filename_environment  do
          ::        CommentsProcess::Pure::MyFile.stub :filename_log,              filename_output_log     do
            ::      CommentsProcess::Pure::MyFile.stub :folder_data_applications,  folder_data_applications  do
              ::    CommentsProcess::Pure::MyFile.stub :folder_data_own,           folder_data_own             do
                ::  Time.stub                          :now,                       time_now                      do
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
