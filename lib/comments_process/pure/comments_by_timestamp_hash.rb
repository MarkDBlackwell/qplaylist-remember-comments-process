# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Pure
      class CommentsByTimestampHash
        module InstanceMethods

          include ::Enumerable

          def initialize(period_comments)
            @comments_by_timestamp_hash = comments_by_timestamp_hash period_comments
          end

          def each
            unless block_given?
              @comments_by_timestamp_hash.each
            else
## 'each(&:yield)' doesn't work, here.
              @comments_by_timestamp_hash.each{|e| yield e}
            end
          end

          private

          def comments_by_timestamp_hash(period_comments)
            grouped = period_comments.group_by(&:timestamp)
            grouped.sort.to_h
          end
        end

        include InstanceMethods
      end
    end
  end
end
