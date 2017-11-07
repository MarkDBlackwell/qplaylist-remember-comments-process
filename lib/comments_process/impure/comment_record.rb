# coding: utf-8

module ::CommentsProcess
  module Impure
    class CommentRecord

      include ::Comparable

# Keep before attr_reader:
      def self.names_ordered
        %i[
            year
            month
            mday
            hour
            minute
            internet_protocol_address
            user_identifier
            category
            ]
      end

      attr_reader(*names_ordered)
      attr_accessor :rest
      attr_accessor :seq

      def initialize(comment_record)
        count_regular = self.class.names_ordered.length
        all = comment_record.split ' '
        raise unless all.length >= count_regular.succ
        a = all.take count_regular
        names_ordered.each_with_index{|e,i| instance_variable_set :"@#{e}", (a.at i)}
        @rest = (all.drop count_regular).join ' '
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
