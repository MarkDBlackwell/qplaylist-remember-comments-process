# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require_relative '../test_helper'
require 'command_pure'
require 'email_record'
require 'period_record'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    class CommandPureDoEmailGenerateTest < QplaylistRememberCommentsProcessTest
      module InstanceMethods

        def test_do_email_generate
          actual = Pure::CommandPure.send :do_email_generate, model, data
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

        def data
          period_array = %w[
              sun
              17
              19
              bob
              bobsmith@example.com
              ]
          period_line = period_array.join ' '
          period = Pure::PeriodRecord.new period_line
          comments = ::Array.new
          [period, comments]
        end

        def expected
          email_address_disk_jockey = 'bobsmith@example.com'
          name_first_disk_jockey = 'Bob'
          subject = 'Sun 5 to 7 PM likes'
          email = Pure::EmailRecord.new email_address_disk_jockey, body, name_first_disk_jockey, subject
          trace_write = false
          data_log = ["email #{email.inspect}", trace_write]
          [
              [:do_log_write, data_log ],
              [:do_email_send, email   ],
              ]
        end

        def model
          result = ::Hash.new
          result[:current_time] = ::Time.new 2003, 4, 5, 18, 15
          result[:email_address_daemon] = 'some-mail-username@example.com'
          result[:email_password_daemon] = 'some-mail-password'
          result[:email_sent_count] = 0
          result[:schedule_source] = 'some-schedule_source'
          result
        end
      end

      include InstanceMethods
    end
  end
end
