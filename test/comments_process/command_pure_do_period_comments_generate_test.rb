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

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    class CommandPureDoPeriodCommentsGenerateTest < QplaylistRememberCommentsProcessTest
      module InstanceMethods

        def test_do_period_comments_generate
        end

        def test_do_period_comments_generate_empty
          expected = expected_empty
          model = model_empty
=begin
          model_empty = ::Hash.new

          period_empty = 
          trace_write = false
          data_empty = ["No comments in period #{period_empty.air_show}", trace_write]
          model_empty[:comments] = [:do_log_write, data_empty]

          expected_empty = 
          actual = Pure::CommandPure.send :do_period_comments_generate, model_empty, period_empty
          assert_equal expected_empty, actual
=end
        end

        private

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
        end

        def expected
        end

        def expected_empty
        end

        def model
          result = ::Hash.new
          result[:current_time] = ::Time.new 2003, 4, 5, 18, 15
        end

        def model_empty
        end
      end

      include InstanceMethods
    end
  end
end
