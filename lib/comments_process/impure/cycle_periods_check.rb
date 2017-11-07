# coding: utf-8

require 'commands'
require 'init'

module ::CommentsProcess
  module Impure
    module CyclePeriodsCheck
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
          list.push [:do_periods_load_and_filter, ::Array.new]
        end

        def envelope_stop
          no_periods_match = 3
          ::Kernel.exit no_periods_match
          nil
        end

        def exit_error_possibly
#print 'Commands.model[:periods_current]='; pp Commands.model[:periods_current]
          envelope_stop if Commands.model[:periods_current].empty?
          nil
        end
      end

      extend ::CommentsProcess::Impure::CyclePeriodsCheck::ClassMethods
    end
  end
end
