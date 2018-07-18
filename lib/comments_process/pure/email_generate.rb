# coding: utf-8

require 'email_record'
require 'my_time'

module ::CommentsProcess
  module Pure
    module EmailGenerate
      module ClassMethods


# TODO: Three Likes on Song cThree. They should be on Song bTwo, per:
#   test/mail/fixture/comments.txt
#   test/mail/fixture/log.txt

        def generate(model, period, period_comments)
          date_air = "#{MyTime.current_year( model).to_s.rjust 4, '0'
                    }-#{MyTime.current_month(model).to_s.rjust 2, '0'
                    }-#{MyTime.current_mday( model).to_s.rjust 2, '0'
                    }"
          email_address_disk_jockey = period.email_address_disk_jockey
          name_first_disk_jockey = period.name_first_disk_jockey
          song_section = swathes_by_song(period_comments).join "\n"
          subject = "#{period.weekday.capitalize} #{period_string period} likes"
# Depends on above.
          body = email_body date_air, name_first_disk_jockey, song_section
          EmailRecord.new email_address_disk_jockey, body, name_first_disk_jockey, subject
        end

        private

        def comments_by_timestamp(comments)
          grouped = comments.group_by do |comment|
            MyTime.ymdhm.map{|field| comment.send field}.join ' '
          end
          grouped.sort.to_h
        end

        def comments_by_user(comments)
          grouped = comments_sorted(comments).group_by do |comment|
            fields_group_by_user.map{|field| comment.send field}.join ' '
          end
          grouped.sort.to_h
        end

        def comments_coalesced(comments_for_one_timestamp)
          hash = ::Hash.new
          comments_by_user(comments_for_one_timestamp).each_pair do |key, unsorted|
            a = unsorted.sort{|x,y| x.seq <=> y.seq}
            hash[key] = a.first
            hash[key].rest = a.map(&:rest).join '; '
          end
          hash.values
        end

        def comments_selected(comments)
          comments.select{|e| "c" == e.category}
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
          likes = comments.select{|e| "l" == e.category}
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
              comments
              ]
## Methods accessed: #comments_coalesced #likes_coalesced #song_coalesced
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
          song = comments.select{|e| "s" == e.category}
          song.uniq{|e| e.rest}.sort{|x,y| x.rest <=> y.rest}
        end

        def swathes_by_song(period_comments)
          hash = ::Hash.new
          names = names_method
          ensure_at_least_one = ['']
          comments_by_timestamp(period_comments).each_pair do |key, array|
            combined = names.map{|e| send e, array}.reduce :+
            hash[key] = combined.compact.map(&:rest) + ensure_at_least_one
          end
          hash.values.flatten 1
        end
      end

      extend ::CommentsProcess::Pure::EmailGenerate::ClassMethods
    end
  end
end
