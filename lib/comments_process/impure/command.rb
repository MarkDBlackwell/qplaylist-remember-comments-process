# coding: utf-8

require 'command_pure'
require 'comment_record'
require 'email_send'
require 'my_file'
require 'period_record'

module ::CommentsProcess
  module Impure
    module Command
      module ClassMethods

        def process(model, command)
## The instructions (the opcodes for the commands) are symbols, beginning
## with 'do_', and are defined as private methods, either:
##   1. In this module; or
##   2. In module CommandPure.

          @model = model.dup # See Model#initialize_copy.
          @commands_to_add = ::Array.new
#print 'command='; p command
          instruction, @data = command
          unless commands_pure.include? instruction
            Command.send instruction
          else
            @commands_to_add = Pure::CommandPure.send instruction, @model, @data
          end
          [@model, @commands_to_add]
        end

        private

        def command_push(command)
          @commands_to_add.push command
          nil
        end

        def commands_pure
          %i[do_email_generate  do_period_comments_generate  do_periods_process]
        end

        def comments_sequentialize(comments)
# Add a sequence field, because Ruby's Array#sort doesn't guarantee
# that it preserves order. See:
# https://stackoverflow.com/a/15442966/1136063
          highest = comments.length - 1
          highest_length = highest.to_s.length
          (0..highest).each{|i| comments[i].seq = i.to_s.ljust highest_length, '0'}
          nil
        end

        def do_comments_read
          lines = Pure::MyFile.file_lines Pure::MyFile.filename_comments
          comments = lines.map{|e| CommentRecord.new e}
          comments_sequentialize comments
          @model[:comments] = comments
          nil
        end

        def do_email_send
          EmailSend.email_send @model, @data
          nil
        end

        def do_log_write
          message_raw, trace_write = @data
          message = whitespace_compress message_raw
          time = log_write_time
          line = "#{time} #{message}\n"
          ::File.open Pure::MyFile.filename_log, 'a' do |f|
            f.print line
#print 'trace_write='; p trace_write
            if trace_write
              entries_omit_count = 3
              execution_stack = ::Kernel.caller entries_omit_count
              execution_stack.each{|e| f.print "#{time} #{e}\n"}
            end
          end
          nil
        end

        def do_periods_load_and_filter
          lines = Pure::MyFile.file_lines periods_file
#print 'lines='; pp lines
          periods = lines.map{|e| Pure::PeriodRecord.new e}
          wday = Pure::MyTime.current_wday @model
          hour = Pure::MyTime.current_hour @model
          @model[:periods_current] = periods.select{|e| e.matches wday, hour}
#print '@model[:periods_current]='; pp @model[:periods_current]
          nil
        end

        def log_write_time
          format = '%Y-%m-%d %^a %H:%M:%S'
          ::Time.now.strftime format
        end

        def periods_file
          result = @model[:schedule_source]
#print 'result='; pp result
          source_okay = (::File.file? result) && (::File.readable? result)
#print 'source_okay='; pp source_okay
          unless source_okay
            trace_write = true
            data = ["Schedule file: #{result} inaccessible", trace_write]
            command_push [:do_log_write, data]
          end
          result
        end

        def whitespace_compress(s)
          s.strip.gsub whitespace_compress_regexp, ' '
        end

        def whitespace_compress_regexp
           @whitespace_compress_regexp_value ||= ::Regexp.new '\s++', ::Regexp::MULTILINE
        end
      end

      extend ::CommentsProcess::Impure::Command::ClassMethods
    end
  end
end
