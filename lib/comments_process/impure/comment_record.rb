# coding: utf-8

require 'comment_record_pure'

module ::CommentsProcess
  module Impure
    class CommentRecord < Pure::CommentRecordPure

      attr_accessor :rest_improved
      attr_accessor :seq
    end
  end
end
