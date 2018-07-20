# coding: utf-8

require 'comment_record'

module ::CommentsProcess
  module Pure
    class Song

      include ::Comparable

# Keep before attr_reader:
      def self.names
        %i[
            ]
      end

      attr_reader(*names)

      def initialize
      end

      def <=>(other)
        
      end
    end
  end
end
