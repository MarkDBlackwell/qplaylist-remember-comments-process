# coding: utf-8

require_relative 'test_helper_minitest'
require 'pp'

dirname_file_current = ::Kernel.__dir__
test = ::File.join dirname_file_current, '.'
lib  = ::File.join test, '..', 'lib'
package = 'comments_process'
legs_ordered = %w[
    pure
    impure
    ]
branches = legs_ordered.map{|leaf| ::File.join lib, package, leaf}

branches.each do        |branch|
  real = ::File.realpath branch
  $LOAD_PATH.unshift real unless $LOAD_PATH.include? real
end

module ::CommentsProcess
end

class CommentsProcessTest < ::Minitest::Test
  include ::CommentsProcess
end
