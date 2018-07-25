# coding: utf-8

require_relative '../test_helper'
require_relative 'command_test_instance_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    class CommandTest < QplaylistRememberCommentsProcessTest
      include InstanceMethods
    end
  end
end
