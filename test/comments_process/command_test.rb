# coding: utf-8

require_relative '../test_helper'
require 'command'

class CommandTest < CommentsProcessTest

  def test_comments_sequence_numbers
    a = 11.times.to_a
    actual = Impure::Command.send :sequence_numbers, a
    expected = %w[00 01 02 03 04 05 06 07 08 09 10]
    assert_equal expected, actual
  end
end

