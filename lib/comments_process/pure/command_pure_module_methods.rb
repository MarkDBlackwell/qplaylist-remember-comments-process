# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'email_generate_module_methods'
require 'my_time_module_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Pure
      module CommandPure
        module ModuleMethods

          private

          def comment_time(comment)
            arguments = comment.timestamp.split(' ').map(&:to_i)
            ::Time.new(*arguments)
          end

          def comments_in_period(model, period)
            window_start, window_end = window_start_end model, period
            model[:comments].select do |comment|
              time = comment_time comment
              time >= window_start &&
              time <= window_end
            end
          end

          def do_email_generate(model, pair)
            period, comments = pair
            commands = ::Array.new
            email = EmailGenerate.generate model, period, comments
            trace_write = false
            data = ["email #{email.inspect}", trace_write]
            commands.push [:do_log_write, data]
            commands.push [:do_email_send, email]
          end

          def do_period_comments_generate(model, period)
            period_comments = comments_in_period model, period
            command = if period_comments.empty?
              trace_write = false
              data = ["No comments in period #{period.air_show}", trace_write]
              [:do_log_write, data]
            else
              data = [period, period_comments]
              [:do_email_generate, data]
            end
            [command]
          end

          def do_periods_process(model, _)
## Okay to return empty array--Commands.process can handle it:
            model[:periods_current].map{|e| [:do_period_comments_generate, e]}
          end

          def window_start_end(model, period)
            now = MyTime.current_ymd model
            window_end = ::Time.new(*now, period.hour_end) + MyTime.few_minutes
            window_start_provisional = ::Time.new(*now, period.hour_start) - MyTime.few_minutes
            if period.hour_start <= period.hour_end
              window_start = window_start_provisional
            else
              window_start = window_start_provisional - MyTime.one_full_day
            end
            [window_start, window_end]
          end
        end

        extend ModuleMethods
      end
    end
  end
end
