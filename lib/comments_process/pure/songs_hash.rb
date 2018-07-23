# coding: utf-8

require 'comments_by_timestamp_hash'
require 'helper'

module ::CommentsProcess
  module Pure
#   class SongsHash < ::Hash
#-------------
    class SongsHash

      include ::Enumerable
      include Helper

      def initialize(period_comments)
        @songs = ::Hash.new
        hash = CommentsByTimestampHash.new period_comments
        hash.map do |timestamp, comments_array|
          segregated = segregate_by_song_hash timestamp, comments_array
          @songs.merge! segregated
        end
      end

      def each
        unless block_given?
          @songs.each
        else
## 'each(&:yield)' doesn't work, here.
          @songs.each{|e| yield e}
        end
      end

      def inspect
        result = ::Array.new
        result.push '{'
        @songs.each do |k, v|
          result.push(*[ "\n",  k.inspect,  "=>\n[" ])
          result.push v.map{|e| e.inspect}.join ",\n"
          result.push "]"
        end
        result.push "}\n"
        result.join ''
      end

      def length
        @songs.length
      end

      def to_a
        @songs.to_a
      end

      def values
        @songs.values
      end

      private

      def segregate_by_song_hash(key, comment_lines_timestamp_unsorted)
        by_sequence = sort_by_sequence_array comment_lines_timestamp_unsorted
        result = ::Hash.new
        index, key_big, position = ::Array.new(3) # Predefine for block.
        song_info = ::Array.new
        by_sequence.each do |comment_line|
          if 's' == comment_line.category
            index = song_info.find_index{|item| comment_line.rest == item}
            position = if index
              index
            else
              result.length
            end
            key_big = [key, position]
            next if index
            song_info.push comment_line.rest
            result.store key_big, [comment_line]
          else
            a = result.fetch key_big
            bigger = a.push comment_line
            result.store key_big, bigger
          end
        end
        result
      end

#     def sort_song_comments_by_sequence(song_comments_by_sequence)
#       result = ::Hash.new
#       song_comments_by_sequence.each do |key, comment_lines_unsorted|
#           by_sequence = sort_by_sequence_array comment_lines_unsorted
#         result.store key, by_sequence
#       end
#       result
#     end
    end
  end
end
