# coding: utf-8

require 'my_file'

module ::CommentsProcess
  module Pure
    module Helper
      module InstanceMethods

        def comments_array_dump(comments_array, name)
          ::File.open MyFile.filename_dump, 'a' do |f|
            f.print "#{name}.inspect=[\n"
##          f.print comments_array.map(&:class).uniq, "\n"
            s = comments_array.map{|e| e.inspect}.join ",\n"
            f.print s
            f.print "]\n"
          end
        end

        def comments_hash_dump(comments_hash, name)
          ::File.open MyFile.filename_dump, 'a' do |f|
            f.print "#{name}.inspect=", comments_hash.inspect
          end
        end

        def sequence_numbers(a)
          return ::Array.new if a.empty?
          highest = a.length - 1
          (0..highest).to_a
        end

        def sort_by_sequence_array(comments_array, raise_flag=true)
          result = comments_array.sort{|x,y| x.seq <=> y.seq}
##comments_array_dump result, 'result'
          if raise_flag
            raise unless result.empty? || 's' == result.first.category
          end
          result
        end
      end
    end
  end
end
