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
    class CommandPureDoPeriodsProcessTest < QplaylistRememberCommentsProcessTest
      module InstanceMethods

        def test_do_periods_process
          data = nil
          actual = Pure::CommandPure.send :do_periods_process, model, data
          assert_equal expected, actual
        end

        private

        def data
        end

        def expected
          [
              [:do_period_comments_generate, 'a' ],
              [:do_period_comments_generate, 'b' ],
              [:do_period_comments_generate, 'c' ],
              ]
        end

        def model
          result = ::Hash.new
          result[:periods_current] = %w[a b c]
          result
        end
      end

      include InstanceMethods
    end
  end
end
