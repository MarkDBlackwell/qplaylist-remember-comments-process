# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require_relative 'test_helper_minitest'
require_relative 'test_helper_stub'
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

module ::QplaylistRememberCommentsProcess
  class QplaylistRememberCommentsProcessTest < ::Minitest::Test
  end
end
