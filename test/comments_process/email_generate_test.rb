# coding: utf-8

require_relative '../test_helper'
require_relative 'email_generate_test_instance_methods'

module ::QplaylistRememberCommentsProcessTest
  module CommentsProcess
    class EmailGenerateTest < CommentsProcessTest
      include ::QplaylistRememberCommentsProcessTest::CommentsProcess::EmailGenerateTest::InstanceMethods
    end
  end
end
