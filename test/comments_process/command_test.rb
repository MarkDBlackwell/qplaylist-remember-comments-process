# coding: utf-8

require_relative '../test_helper'
require 'command'

class CommandTest < CommentsProcessTest

  def test_comments_sequence_numbers
    count = 11
    a = %w[a]*count
    actual = Impure::Command.send :sequence_numbers, a
    expected = count.times.to_a
    assert_equal expected, actual
  end
end

