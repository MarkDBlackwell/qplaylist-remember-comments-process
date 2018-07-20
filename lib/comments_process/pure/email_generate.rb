# coding: utf-8

require 'email_record'
require 'my_time'
require 'songs'

module ::CommentsProcess
  module Pure
    module EmailGenerate
      module ClassMethods


# TODO: Three Likes on Song cThree. They should be on Song bTwo, per:
#   test/mail/fixture/comments.txt
#   test/mail/fixture/log.txt

        def generate(model, period, period_comments)
          subject = "#{period.weekday.capitalize} #{period_string period} likes"
          song_section = swathes_by_song(period_comments).join "\n"
          forename = period.name_first_disk_jockey
          date_air = MyTime.current_time_ymd_dashes model
# Depends on above.
          body = email_body date_air, forename, song_section
          EmailRecord.new period.email_address_disk_jockey, body, forename, subject
        end

        private

        def comments_by_song(period_comments)
          result = ::Hash.new
#         by_timestamp = comments_by_timestamp period_comments
#         by_timestamp.each do |key, comment_lines|

          comments_by_timestamp(period_comments).each do |key, comment_lines_unsorted|
            comment_lines = comment_lines_unsorted.sort{|x,y| x.seq <=> y.seq}
            timestamp_songs = ::Array

            raise if result.empty? && comment_lines.first.category != 's'
            comment_lines.each do |comment_line|
              if 's' == comment_line.category
                position = result.length
                key_big = [key, position]
                result[key_big] = [comment_line]
              else
                result[key_big].push comment_line
              end

?          song = comments.select{|e| 's' == e.category}
?          song.uniq{|e| e.rest}.sort{|x,y| x.rest <=> y.rest}

?         comments_by_song(period_comments).each do |key, array|
?         ensure_at_least_one = ['']
?           hash[key] = combined.compact.map(&:rest) + ensure_at_least_one
        end

        def comments_by_user(comments)
          grouped = comments_sorted(comments).group_by do |comment|
            fields_group_by_user.map{|field| comment.send field}.join ' '
          end
          grouped.sort.to_h
        end

        def comments_selected(comments)
          comments.select{|e| 'c' == e.category}
        end

        def comments_sorted(comments)
          fields = fields_group_by_user + %i[seq]
          comments_selected(comments).sort do |x,y|
            key_x, key_y = [x,y].map do |e|
              fields.map{|field| e.send field}.join ' '
            end
            key_x <=> key_y
          end
        end

        def comments_written_coalesced(comments_for_one_timestamp)
          hash = ::Hash.new
          comments_by_user(comments_for_one_timestamp).each do |key, unsorted|
            a = unsorted.sort{|x,y| x.seq <=> y.seq}
            hash[key] = a.first
            hash[key].rest = a.map(&:rest).join '; '
          end
          hash.values
        end

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

        def likes_coalesced(comments)
          likes = comments.select{|e| 'l' == e.category}
          like = likes.first
          if likes.length > 1
            like.rest += " (#{likes.length})"
          end
          [like]
        end

        def names_method
          names_partial_ordered = %w[
              song
              likes
              comments_written
              ]
## Methods accessed: #comments_written_coalesced #likes_coalesced #song_coalesced
          names_partial_ordered.map{|e| "#{e}_coalesced"}
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

        def song_coalesced(comments)
          song = comments.select{|e| 's' == e.category}
          song.uniq{|e| e.rest}.sort{|x,y| x.rest <=> y.rest}
        end

        def swathes_by_song(period_comments)
=begin
          hash = ::Hash.new
          ensure_at_least_one = ['']
          comments_by_song(period_comments).each do |key, array|
            combined = names_method.map{|e| send e, array}.reduce :+
            hash[key] = combined.compact.map(&:rest) + ensure_at_least_one
          end
          hash.values.flatten 1
=end
          songs = Songs.new period_comments

        end
      end

      extend ::CommentsProcess::Pure::EmailGenerate::ClassMethods
    end
  end
end
