# coding: utf-8

require 'command'

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
