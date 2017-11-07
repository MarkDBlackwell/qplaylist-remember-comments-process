# coding: utf-8

require 'my_time'

module ::CommentsProcess
  module Pure
    class PeriodRecord

# Keep before attr_reader:
      def self.names
        %i[
            email_address_disk_jockey
            hour_end
            hour_start
            name_first_disk_jockey
            weekday
            ]
      end

      attr_reader(*names)

      def initialize(line)
        a = line.split ' '
        raise unless 5 == a.length
        weekday, hour_start, hour_end, name_first_disk_jockey, @email_address_disk_jockey = a
        @hour_end   = hour_end  .to_i % MyTime.one_full_day_in_hours
        @hour_start = hour_start.to_i % MyTime.one_full_day_in_hours
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

      def matches(wday_end, hour)
        wday_start = if hour_start <= hour_end
          wday_end
        else
          week_length = 7
          (wday_end - 1) % week_length
        end
        weekday_good = weekday == (MyTime.weekday_s wday_start)
        hour_good    = hour_end == hour
        weekday_good && hour_good
      end

      def to_s
        '' # During test development, avoid puzzlement.
      end
    end
  end
end
