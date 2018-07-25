# coding: utf-8

require 'command'

module ::QplaylistRememberCommentsProcessTest
  module CommentsProcess
    class CommandTest < CommentsProcessTest
      module InstanceMethods

        def test_comments_sequence_numbers
          count = 11
          a = %w[a]*count
          actual = ::CommentsProcess::Impure::Command.send :sequence_numbers, a
          expected = count.times.to_a
          assert_equal expected, actual
        end
      end
    end
  end
end
