# coding: utf-8

module ::CommentsProcess
  module Pure
#   class CommentsByTimestampHash < ::Hash
    class CommentsByTimestampHash

      include ::Enumerable

      def initialize(period_comments)
#print 'period_comments.slice(0..0)='; pp period_comments.slice(0..0)
#-------------
        @comments_by_timestamp_hash = comments_by_timestamp_hash period_comments
      end

      def each
##        @comments_by_timestamp_hash.each(&:yield)
#         @comments_by_timestamp_hash.each{|e| yield e}.to_h

        unless block_given?
          @comments_by_timestamp_hash.each
        else
## 'each(&:yield)' doesn't work, here.
          @comments_by_timestamp_hash.each{|e| yield e}
        end
      end

      def inspect
        @comments_by_timestamp_hash.inspect
      end

      def keys
        @comments_by_timestamp_hash.keys
      end

      def to_a
        @comments_by_timestamp_hash.to_a
      end

      def values
        @comments_by_timestamp_hash.values
      end

      private

      def comments_by_timestamp_hash(period_comments)
#print 'period_comments.slice(0..0)='; pp period_comments.slice(0..0)
#-------------
        grouped = period_comments.group_by(&:timestamp)
        grouped.sort.to_h
      end
    end
  end
end
