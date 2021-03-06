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
      module CyclePeriodsCheck
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
            list.push [:do_periods_load_and_filter, ::Array.new]
          end

          def envelope_stop
            no_periods_match = 3
            ::Kernel.exit no_periods_match
            nil
          end

          def exit_error_possibly
            envelope_stop if Commands.model[:periods_current].empty?
            nil
          end
        end

        extend ModuleMethods
      end
    end
  end
end
