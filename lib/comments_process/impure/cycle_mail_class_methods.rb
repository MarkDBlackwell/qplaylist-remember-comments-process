# coding: utf-8

require 'commands'
require 'init'

module ::CommentsProcess
  module Impure
    module CycleMail
      module ClassMethods

        def run
          Commands.model = Init.run
          Commands.process commands_initial
          exit_error_possibly
          nil
        end

        private

        def commands_initial
          list = ::Array.new
          list.push [:do_comments_read,           ::Array.new]
          list.push [:do_periods_load_and_filter, ::Array.new]
          list.push [:do_periods_process,         ::Array.new]
        end

        def envelope_stop
          no_emails_sent = 2
          ::Kernel.exit no_emails_sent
          nil
        end

        def exit_error_possibly
          envelope_stop unless Commands.model[:email_sent_count] > 0
          nil
        end
      end
    end
  end
end
