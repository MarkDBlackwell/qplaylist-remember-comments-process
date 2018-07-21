# coding: utf-8

require 'comments_by_timestamp'
require 'helper'

module ::CommentsProcess
  module Pure
#   class SongsHash < ::Hash
    class SongsHash

      include ::Enumerable
      include Helper

      def initialize(period_comments)
#print 'period_comments.slice(0..1)='; pp period_comments.slice(0..1)
#print 'hash.inspect='; pp hash.inspect
#print 'hash.to_a.first='; pp hash.to_a.first
#print 'k='; pp k
#print 'v.slice(0..0)='; pp v.slice(0..0)
#print '@songs='; pp @songs
#       @songs = ::Hash.new
#       @songs.store :a, 1
#       @array = hash.map{|k,v| segregate_by_song k, v}
#         @songs.merge!(segregate_by_song k, v)
#       self
#       sorted = sort_song_comments_by_sequence @songs
#       @songs = sorted
#print 'hash='; pp hash

        @songs = ::Hash.new
        hash = CommentsByTimestamp.new period_comments
print 'hash.keys='; pp hash.keys
print 'hash.values='; pp hash.values
        hash.map do |k, v|
          segregated = segregate_by_song k, v
          @songs.merge! segregated
        end
      end

      def each
#         @songs.each(&:yield).to_h
#         @songs.each{|e| yield e}.to_h

        unless block_given?
          @songs.each
        else
## 'each(&:yield)' doesn't work, here.
          @songs.each{|e| yield e}
        end
      end

      def inspect
        result = ::Array.new
        @songs.each do |k, v|
          result.push [k.inspect, v.inspect]
        end
        result
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

      def segregate_by_song(key, comment_lines_unsorted)
#print 'result='; pp result
#print 'result='; pp result
#print 'result='; pp result
#       songs = ::Array.new
#           next if songs.include? comment_line.rest
#           songs.push comment_line.rest
#           result.fetch(key_big).push comment_line

        by_sequence = sort_by_sequence_array comment_lines_unsorted
        result = ::Hash.new
        index, key_big, position = ::Array.new(3) # Predefine for block.
        by_sequence.each do |comment_line|
          if 's' == comment_line.category
            index = result.keys.find_index{|k| comment_line.rest == k}
            position = if index
              index
            else
              result.length
            end
            key_big = [key, position]
            next if index
            result.store key_big, [comment_line]
          else
            a = result.fetch key_big
            bigger = a.push comment_line
            result.store key_big, bigger
          end
        end
        result
      end

      def sort_song_comments_by_sequence(song_comments_by_sequence)
#print '@songs='; pp @songs
#print '@songs.length='; pp @songs.length
#print '@songs.map{|e| e.length}='; pp @songs.map{|e| e.length}
#print '@songs.map{|e| e.map{|d| d.length}}='; pp @songs.map{|e| e.map{|d| d.length}}
#print 'song_comments.slice(0..0)='; pp song_comments.slice(0..0)
#print 'song_comments='; pp song_comments
###print 'hash.to_a.first='; pp hash.to_a.first
#print 'values='; pp values
#       sorted = ::Hash.new
#       @songs.each do |key, song_comments|
#         hash = CommentsByTimestamp.new song_comments
#         values = hash.values.sort.flatten 1
#         sorted.store key, (values.flatten 1)
#         sorted.store key, values
#       end
#       @songs.replace sorted

        result = ::Hash.new
        song_comments_by_sequence.each do |key, comment_lines_unsorted|
            by_sequence = sort_by_sequence_array comment_lines_unsorted
          result.store key, by_sequence
        end
        result
      end
    end
  end
end
