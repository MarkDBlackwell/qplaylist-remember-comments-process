# coding: utf-8

require 'my_time'

module ::CommentsProcess
  module Impure
    class CommentRecord

      include ::Comparable

# Keep before attr_reader:
      def self.names_ordered
        additional = %w[
            internet_protocol_address
            user_identifier
            category
            ]
        Pure::MyTime.ymdhm + additional
      end

      attr_reader(*names_ordered)
      attr_accessor :rest
      attr_accessor :seq

      def initialize(comment_record)
        count_ever_present = self.class.names_ordered.length
        all = comment_record.split ' '
        raise unless all.length > count_ever_present
        ever_present = all.take count_ever_present
        names_ordered.zip(ever_present).each{|name,value| instance_variable_set :"@#{name}", value}
        @rest = (all.drop count_ever_present).join ' '
      end

      def <=>(other)
        check_other = names_ordered.map{|e| other.send e}.join ' '
        check_this  = names_ordered.map{|e|       send e}.join ' '
        check_this <=> check_other
      end

      def names_ordered
        self.class.names_ordered
      end
    end
  end
end
