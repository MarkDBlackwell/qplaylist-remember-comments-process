# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'command_module_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    class CommandTest < QplaylistRememberCommentsProcessTest
      module InstanceMethods

        def test_comments_sequence_numbers
          count = 11
          a = %w[a]*count
          actual = Impure::Command.send :sequence_numbers, a
          expected = count.times.to_a
          assert_equal expected, actual
        end
      end
    end
  end
end
