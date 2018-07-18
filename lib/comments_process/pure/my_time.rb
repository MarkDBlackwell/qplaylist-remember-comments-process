# coding: utf-8

module ::CommentsProcess
  module Pure
    module MyTime
      module ClassMethods

        def current_hour(model)
          current_time(model).hour
        end

        def current_mday(model)
          current_time(model).mday
        end

        def current_month(model)
          current_time(model).month
        end

        def current_wday(model)
          current_time(model).wday
        end

        def current_year(model)
          current_time(model).year
        end

        def current_ymd(model)
          ymd.map{|e| "current_#{e}".to_sym}.map{|e| send e, model}
        end

        def few_minutes
#  Risks:
# 1. The show could start a few minutes early; and
# 2. The previous show's last song could be included.
          minutes_before_balanced = 4
          one_minute = 60
          one_minute * minutes_before_balanced # In seconds.
        end

        def one_full_day
          one_full_day_in_hours * 60 * 60
        end

        def one_full_day_in_hours
          24
        end

        def weekday_s(i)
          index = i % weekdays.length
          weekdays.at index
        end

        def ymd
          %w[
              year
              month
              mday
              ]
        end

        def ymdhm
          hm = %w[
              hour
              minute
              ]
          ymd + hm
        end

        private

        def current_time(model)
          model[:current_time]
        end

        def weekdays
          %w[
              sun
              mon
              tue
              wed
              thu
              fri
              sat
              ]
        end
      end

      extend ::CommentsProcess::Pure::MyTime::ClassMethods
    end
  end
end
