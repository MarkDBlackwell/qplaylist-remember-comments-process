# coding: utf-8

module ::CommentsProcess
  module Pure
    module Helper

      def sequence_numbers(a)
        return ::Array.new if a.empty?
        highest = a.length - 1
        width = highest.to_s.length
        (0..highest).map{|i| sprintf '%0*i', width, i}
      end

      def sort_by_sequence_array(comments_array)
        result = comments_array.sort{|x,y| x.seq <=> y.seq}
        raise unless 's' == result.first.category unless result.empty?
        result
      end
    end
  end
end
