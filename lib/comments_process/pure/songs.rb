# coding: utf-8

require 'comment_record'
require 'timestamps'

module ::CommentsProcess
  module Pure
    class Songs

      include ::Enumerable

# Keep before attr_reader:
      def self.names
        %i[
            ]
      end

      attr_reader(*names)

      def initialize(period_comments)
        @songs = ::Array.new
        timestamps = Timestamps.new period_comments
        timestamps.each do |key, comment_lines|
      end

      def each
        @songs.each{|e| yield e}
      end
    end
  end
end
