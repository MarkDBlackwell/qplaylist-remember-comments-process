# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require_relative 'test_fixture_data'
require_relative 'test_fixture_model'
require 'command_pure_module_methods'
require 'email_record'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    class CommandPureTest < QplaylistRememberCommentsProcessTest
      module InstanceMethods

        def setup
          @model = TestFixtureModel.new.value
          @data  = TestFixtureData. new.value
        end

        def test_email_generate
          setup
          email_address_disk_jockey = 'bobsmith@example.com'
          name_first_disk_jockey = 'Bob'
          subject = 'Sun 5 to 7 PM likes'
          email = Pure::EmailRecord.new email_address_disk_jockey, body, name_first_disk_jockey, subject
          trace_write = false
          data_log = ["email #{email.inspect}", trace_write]
          expected = [
              [:do_log_write, data_log],
              [:do_email_send, email],
              ]
          actual = Pure::CommandPure.send :do_email_generate, @model, @data
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
