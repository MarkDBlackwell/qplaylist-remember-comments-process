# coding: utf-8

require_relative 'test_helper_minitest'

dirname_file_current = ::Kernel.__dir__
test = ::File.join dirname_file_current, '.'
lib  = ::File.join test, '..', 'lib'

impure, pure = %w[ impure pure ].map{|e| ::File.join lib, 'comments_process', e}

[pure, impure].each do |branch|
  real = ::File.realpath branch
  $LOAD_PATH.unshift real unless $LOAD_PATH.include? real
end

module ::CommentsProcess
end

class CommentsProcessTest < Minitest::Test
  include ::CommentsProcess
end
