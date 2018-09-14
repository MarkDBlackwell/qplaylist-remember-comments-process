# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'comment_record_pure'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Impure
      class CommentRecord < Pure::CommentRecordPure
        module InstanceMethods

          attr_accessor :rest_improved
          attr_accessor :seq
        end
      end
    end
  end
end
