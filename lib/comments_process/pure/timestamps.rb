# coding: utf-8

require 'my_time'

module ::CommentsProcess
  module Pure
    class Timestamps

      include ::Enumerable

# Keep before attr_reader:
      def self.names
        %i[
            ]
      end

      attr_reader(*names)

      def initialize(period_comments)
        @timestamps = comments_by_timestamp period_comments
      end

      private

      def comments_by_timestamp(period_comments)
        grouped = period_comments.group_by do |comment|
          MyTime.ymdhm.map{|field| comment.send field}.join ' '
        end
        grouped.sort.to_h
      end

      def each
        @timestamps.each{|e| yield e}
      end
    end
  end
end
