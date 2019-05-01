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
    class CommandPureDoCommentsProcessTest < QplaylistRememberCommentsProcessTest
      module InstanceMethods

        def test_do_comments_process
#         actual = Pure::CommandPure.send :do_comments_process, model, data
#         assert_equal expected, actual
        end

        private

        def data
        end

        def expected
        end

        def model
        end
      end

      include InstanceMethods
    end
  end
end
