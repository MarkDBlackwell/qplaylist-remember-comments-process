# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'command_pure'
require 'email_send'
#require 'helper'
require 'logger'
require 'my_file'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Impure
      module Command
        module ModuleMethods

          include Pure::Helper::ModuleMethods

          def command_process(model_previous, command)
## The instructions (the opcodes for the commands) are symbols, beginning
## with 'do_', and are defined as private methods, either:
##   1. In this module; or
##   2. In module CommandPure.
#-------------
            model = model_previous.dup # See Model#initialize_copy.
            instruction, data = command
            commands_to_add = unless commands_pure.include? instruction
              self.send instruction model, data
            else
              Pure::CommandPure.send instruction, model, data
            end
            [model, commands_to_add]
          end

          private

          def do_comments_read(model, _)
            model[:comments_lines] = Pure::MyFile.file_lines Pure::MyFile.filename_comments
            ::Array.new # commands
          end

          def do_email_send(model, data)
            EmailSend.email_send model, data
            ::Array.new # commands
          end

          def do_log_write(_, data)
            message_raw, trace_write = data
            message = whitespace_compress message_raw
            Logger.log_write message, trace_write
            ::Array.new # commands
          end

          def do_periods_load(model, _)
            model[:periods_lines_raw], commands = periods_file_lines model
            commands
          end

# Internal:

          def commands_pure
# Keep alphabetized:
            %i[
                do_comments_process
                do_email_generate
                do_period_comments_generate
                do_periods_filter
                do_periods_process
                ]
          end

          def periods_file_lines(model)
            filename = model[:schedule_source]
            source_okay = (::File.file? filename) && (::File.readable? filename)
            if source_okay
              lines = Pure::MyFile.file_lines filename
              commands = ::Array.new
            else
              lines = ::Array.new
              trace_write = true
              data = ["Schedule file: #{filename} inaccessible", trace_write]
              commands = [[:do_log_write, data]]
            end
            [lines, commands]
          end

          def whitespace_compress(s)
            s.strip.gsub whitespace_compress_regexp, ' '
          end

          def whitespace_compress_regexp
            @whitespace_compress_regexp_value ||= ::Regexp.new '\s++', ::Regexp::MULTILINE
          end
        end

        extend ModuleMethods
      end
    end
  end
end
