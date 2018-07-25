# coding: utf-8

require_relative 'test_helper'
require_relative 'comments_process_mail_test_instance_methods'

module ::QplaylistRememberCommentsProcessTest
  class CommentsProcessMailTest < CommentsProcessTest
    include ::QplaylistRememberCommentsProcessTest::CommentsProcessMailTest::InstanceMethods
  end
end
