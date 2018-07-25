# coding: utf-8

require 'my_time'

module ::CommentsProcess
  module Pure
    class PeriodRecord
      module InstanceMethods

        def initialize(line)
          a = line.split ' '
          raise unless 5 == a.length
          hours_day = MyTime.one_full_day_in_hours
          weekday, hour_start, hour_end, name_first_disk_jockey, @email_address_disk_jockey = a
          @hour_end   = hour_end  .to_i % hours_day
          @hour_start = hour_start.to_i % hours_day
          @name_first_disk_jockey = name_first_disk_jockey.capitalize
          @weekday = weekday.downcase
        end

        def air_show
          s = [
              @weekday.upcase,
              @hour_start,
              @hour_end,
              ].join ' '
          "<#{s}>"
        end

        def day_before(weekday)
          week_length = 7
          (weekday - 1) % week_length
        end

        def matches(wday_end, hour)
          wday_start = if hour_start <= hour_end
            wday_end
          else
            day_before wday_end
          end
          weekday_good = weekday == (MyTime.weekday_s wday_start)
          hour_good    = hour_end == hour
          weekday_good && hour_good
        end

        def to_s
          '' # During test development, avoid puzzlement by enforcing use of #airshow, instead.
        end
      end
    end
  end
end
