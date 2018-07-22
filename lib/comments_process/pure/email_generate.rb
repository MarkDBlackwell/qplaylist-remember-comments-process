# coding: utf-8

require 'email_record'
require 'helper'
require 'my_time'
require 'songs_hash'

module ::CommentsProcess
  module Pure
    module EmailGenerate
      module ClassMethods

        include Helper

# TODO: Three Likes on Song cThree. They should be on Song bTwo, per:
#   test/mail/fixture/comments.txt
#   test/mail/fixture/log.txt

        def generate(model, period, period_comments_array)
#print 'period_comments_array.first='; pp period_comments_array.first
#print 'period_comments_array='; pp period_comments_array
#print 'song_section='; pp song_section
#-------------
          subject = "#{period.weekday.capitalize} #{period_string period} likes"
          song_section = swathes_by_song_array(period_comments_array).join "\n"
          forename = period.name_first_disk_jockey
          date_air = MyTime.current_time_ymd_dashes model
# Depends on above.
          body = email_body date_air, forename, song_section
          EmailRecord.new period.email_address_disk_jockey, body, forename, subject
        end

        private

        def email_body(date_air, name_first_disk_jockey, song_section)
<<END
Dear #{name_first_disk_jockey}:
Here are the songs users especially liked from your show, aired on #{date_air}:

#{song_section}
Sincerely,
The Remember Songs daemon
END
        end

        def fields_group_by_user
          %i[
              internet_protocol_address
              user_identifier
              ]
        end

        def likes_coalesced_array(comments_array)
          likes_array = likes_selected_array comments_array
          return ::Array.new if likes_array.empty?
          like = likes_array.first
          single = 1
          like.rest_improved = if likes_array.length == single
            like.rest
          else
            "#{like.rest} (#{likes_array.length})"
          end
          [like]
        end

        def likes_selected_array(comments_array)
          comments_array.select{|e| 'l' == e.category}
        end

        def names_partial_ordered
          %w[
              songs
              likes
              remarks
              ]
        end

        def period_string(period)
          period_twenty_four_hour = [period.hour_start, period.hour_end]
          zero_human = 12
          period_human = period_twenty_four_hour.map{|hour| hour % 12}.map{|hour| 0 == hour ? zero_human : hour}
          meridian_same_to = ' to '
          am_to, pm_to = %w[AM PM].map{|e| " #{e}#{meridian_same_to}"}
          pm_start = 12
          case
          when period_twenty_four_hour.all?{|hour| hour <  pm_start}
            "#{period_human.join meridian_same_to} AM"

          when period_twenty_four_hour.all?{|hour| hour >= pm_start}
            "#{period_human.join meridian_same_to} PM"

          when period_twenty_four_hour.first >= pm_start
            "#{period_human.join pm_to} AM"

          else
            "#{period_human.join am_to} PM"
          end
        end

        def remarks_by_user_hash(comments_array)
          grouped_hash = remarks_sorted(comments_array).group_by do |comment|
            fields_group_by_user.map{|field| comment.send field}.join ' '
          end
          grouped_hash.sort.to_h
        end

        def remarks_coalesced_array(comments_for_one_song_array)
          hash = ::Hash.new
          remarks_by_user_hash(comments_for_one_song_array).each do |key, comments_unsorted_array|
            a = sort_by_sequence_array comments_unsorted_array
            hash.store key, a.first
            hash.fetch(key).rest_improved = a.map(&:rest).join '; '
          end
          hash.values
        end

        def remarks_selected_array(comments_array)
## Previously, remarks were called comments, and 'c' stands for 'comments':
          comments_array.select{|e| 'c' == e.category}
        end

        def remarks_sorted(comments_array)
          fields = fields_group_by_user + %i[seq]
          remarks_selected_array(comments_array).sort do |x,y|
            key_x, key_y = [x,y].map do |e|
              fields.map{|field| e.send field}.join ' '
            end
            key_x <=> key_y
          end
        end

        def songs_coalesced_array(comments_array)
#         selected_array = comments_array.select{|e| 's' == e.category}.map{|e| e.seq = nil}
#         songs_uniq = selected_array.uniq(&:rest)
#         selected_array = comments_array.select{|e| 's' == e.category}
#print 'e.rest='; pp e.rest
#print 'selected_array='; pp selected_array
#print 'result_array='; pp result_array
#print 'songs_uniq='; pp songs_uniq
#-------------
          selected_array = songs_selected_array comments_array
          songs_uniq = selected_array.uniq do |e|
            e.rest
          end
          result_array = sort_by_rest_array songs_uniq
          result_array.each{|e| e.rest_improved = e.rest}
          result_array
        end

        def songs_selected_array(comments_array)
          comments_array.select{|e| 's' == e.category}
        end

        def sort_by_rest_array(comments_array)
          comments_array.sort{|x,y| x.rest <=> y.rest}
        end

        def swathes_by_song_array(period_comments_array)
#print 'period_comments_array.first='; pp period_comments_array.first
#print 'songs.length='; pp songs.length
#print 'songs.inspect='; pp songs.inspect
#print 'songs='; pp songs
#print 'songs.first='; pp songs.first
#print 'songs.values.first.slice(0..10)='; pp songs.values.first.slice(0..10)
#print 'array.slice(0..1)='; pp array.slice(0..1)
#         result_hash.values.flatten 1
# f.print 'songs_hash=', songs_hash, "\n"
#           combined = names_method.map{|e| send e, array}.reduce :+
#           result_hash[key] = combined.compact.map(&:rest_improved) + ensure_at_least_one
#           reduced_safe = reduced.reject(&:empty?)
#print 'combined='; pp combined
#           result_array.push reduced.map(&:rest_improved), reduced + ensure_at_least_one
#print 'reduced='; pp reduced
#print 'result_array='; pp result_array
#-------------
          result_array = ::Array.new
          ensure_at_least_one = ['']
          songs_hash = SongsHash.new period_comments_array
filename_dump = ::File.join __dir__, *['..']*3, 'test', 'shared', 'var', 'dump.txt'
::File.open filename_dump, 'w' do |f|
  f.print 'songs_hash.inspect=', songs_hash.inspect, "\n"
end
          songs_hash.each do |key, comments_array|
## Methods accessed: #likes_coalesced_array #remarks_coalesced_array #_array:
            combined = names_partial_ordered.map{|e| send "#{e}_coalesced_array", comments_array}
            reduced = combined.reduce :+
## TODO: Flatten?
            result_array.push reduced.map(&:rest_improved) + ensure_at_least_one
          end
          result_array
        end
      end

      extend ::CommentsProcess::Pure::EmailGenerate::ClassMethods
    end
  end
end
