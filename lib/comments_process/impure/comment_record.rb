# coding: utf-8

require 'comment_record_instance_methods'

module ::CommentsProcess
  module Impure
    class CommentRecord < Pure::CommentRecordPure
      include ::CommentsProcess::Impure::CommentRecord::InstanceMethods
    end
  end
end
