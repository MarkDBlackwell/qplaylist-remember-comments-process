# coding: utf-8

require 'my_file'

module ::CommentsProcess
  module Impure
    module Logger
      module ClassMethods

        def crash(message)
          trace_write = true
          $stderr.print message
          log_write message, trace_write
          raise
          nil
        end

        def log_write(message, trace_write=false)
          time = log_write_time
          line = "#{time} #{message}\n"
          ::File.open Pure::MyFile.filename_log, 'a' do |f|
            f.print line
#print 'trace_write='; p trace_write
            if trace_write
              entries_omit_count = 4
              execution_stack = ::Kernel.caller entries_omit_count
              if execution_stack
                execution_stack.each{|e| f.print "#{time} #{e}\n"}
              end
            end
          end
          nil
        end

        private

        def log_write_time
# '^a' means upper-case weekday name:
          format = '%Y-%m-%d %^a %H:%M:%S'
          ::Time.now.strftime format
        end

      end

      extend ::CommentsProcess::Impure::Logger::ClassMethods
    end
  end
end
