# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'comment_record_pure_instance_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Pure
      class CommentRecordPure

# Keep before attr_reader:
        def self.names_ordered
          %w[
              internet_protocol_address
              user_identifier
              category
              ]
        end

        attr_reader(*names_ordered)
      end
    end
  end
end
