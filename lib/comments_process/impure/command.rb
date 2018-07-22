# coding: utf-8

require 'command_pure'
require 'comment_record'
require 'email_send'
require 'helper'
require 'logger'
require 'my_file'
require 'period_record'

module ::CommentsProcess
  module Impure
    module Command
      module ClassMethods

        include Pure::Helper

        def process(model, command)
## The instructions (the opcodes for the commands) are symbols, beginning
## with 'do_', and are defined as private methods, either:
##   1. In this module; or
##   2. In module CommandPure.

#print 'command='; p command
#-------------
          @model = model.dup # See Model#initialize_copy.
          @commands_to_add = ::Array.new
          instruction, @data = command
          unless commands_pure.include? instruction
            self.send instruction
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
# Keep alphabetized:
          %i[
              do_email_generate
              do_period_comments_generate
              do_periods_process
              ]
        end

        def comments_sequentialize(comments)
## Add a sequence field, because Ruby's Array#sort doesn't guarantee
## that it preserves order. See:
## https://stackoverflow.com/a/15442966/1136063

# TODO: For sequence numbers, replace strings with integers.
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
          lines = periods_file_lines
# TODO: Ignore blank lines and hash-mark comments.
          periods = lines.map{|e| Pure::PeriodRecord.new e}
          wday = Pure::MyTime.current_wday @model
          hour = Pure::MyTime.current_hour @model
          @model[:periods_current] = periods.select{|e| e.matches wday, hour}
          nil
        end

        def periods_file_lines
          filename = @model[:schedule_source]
          source_okay = (::File.file? filename) && (::File.readable? filename)
          if source_okay
            Pure::MyFile.file_lines filename
          else
            trace_write = true
            data = ["Schedule file: #{filename} inaccessible", trace_write]
            command_push [:do_log_write, data]
            ::Array.new
          end
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
