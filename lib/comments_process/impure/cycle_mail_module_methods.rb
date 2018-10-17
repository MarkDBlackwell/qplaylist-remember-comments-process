# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'commands_module_methods'
require 'init_module_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Impure
      module CycleMail
        module ModuleMethods

          def init
            Commands.model = Init.run
            nil
          end

          def run
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
end
