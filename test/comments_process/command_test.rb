# coding: utf-8

require_relative '../test_helper'
require_relative 'command_test_instance_methods'

module ::QplaylistRememberCommentsProcessTest
  module CommentsProcess
    class CommandTest < CommentsProcessTest
      include InstanceMethods
    end
  end
end
