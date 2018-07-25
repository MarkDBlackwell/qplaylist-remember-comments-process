# coding: utf-8

require_relative 'test_helper_minitest'
require 'pp'

dirname_file_current = ::Kernel.__dir__
lib  = ::File.join dirname_file_current, '..', 'lib'
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

module ::QplaylistRememberCommentsProcessTest
  class CommentsProcessTest < ::Minitest::Test
  end
end
