# coding: utf-8

require 'command_pure'
require 'comment_record'
require 'email_send'
require 'logger'
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
          %i[
              do_email_generate
              do_period_comments_generate
              do_periods_process
              ]
        end

        def comments_sequentialize(comments)
# Add a sequence field, because Ruby's Array#sort doesn't guarantee
# that it preserves order. See:
# https://stackoverflow.com/a/15442966/1136063
          seq = sequence_numbers comments
          comments.zip(seq).each{|comment,sequence| comment.seq = sequence}
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
          Logger.log_write message, trace_write
          nil
        end

        def do_periods_load_and_filter
          lines = Pure::MyFile.file_lines periods_file
#print 'lines='; pp lines
# TODO: Ignore blank lines and hash-mark comments.
          periods = lines.map{|e| Pure::PeriodRecord.new e}
          wday = Pure::MyTime.current_wday @model
          hour = Pure::MyTime.current_hour @model
          @model[:periods_current] = periods.select{|e| e.matches wday, hour}
#print '@model[:periods_current]='; pp @model[:periods_current]
          nil
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

        def sequence_numbers(a)
          highest = a.length - 1
          width = highest.to_s.length
          (0..highest).map{|i| sprintf '%0*i', width, i}
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
