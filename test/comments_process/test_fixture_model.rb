# coding: utf-8

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    class TestFixtureModel

      attr_reader :value

      def initialize
        model = ::Hash.new
        model[:current_time] = ::Time.new 2003, 4, 5, 18, 15
        model[:email_address_daemon] = 'some-mail-username@example.com'
        model[:email_password_daemon] = 'some-mail-password'
        model[:email_sent_count] = 0
        model[:schedule_source] = 'some-schedule_source'
        @value = model
      end
    end
  end
end
