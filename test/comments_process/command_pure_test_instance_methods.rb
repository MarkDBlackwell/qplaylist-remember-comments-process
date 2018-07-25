# coding: utf-8

require_relative 'test_fixture_data'
require_relative 'test_fixture_model'
require 'command_pure'
require 'email_record'

module ::QplaylistRememberCommentsProcessTest
  module CommentsProcess
    class CommandPureTest < CommentsProcessTest
      module InstanceMethods

        def setup
          @model = ::CommentsProcess::TestFixtureModel.new.value
          @data  = ::CommentsProcess::TestFixtureData. new.value
        end

        def test_email_generate
          setup
          email_address_disk_jockey = 'bobsmith@example.com'
          name_first_disk_jockey = 'Bob'
          subject = 'Sun 5 to 7 PM likes'
          email = ::CommentsProcess::Pure::EmailRecord.new email_address_disk_jockey, body, name_first_disk_jockey, subject
          trace_write = false
          data_log = ["email #{email.inspect}", trace_write]
          expected = [
              [:do_log_write, data_log],
              [:do_email_send, email],
              ]
          actual = ::CommentsProcess::Pure::CommandPure.send :do_email_generate, @model, @data
          assert_equal expected, actual
        end

        private

        def body
          <<HEREDOC
Dear Bob:
Here are the songs users especially liked from your show, aired on 2003-04-05:


Sincerely,
The Remember Songs daemon
HEREDOC
        end
      end
    end
  end
end
