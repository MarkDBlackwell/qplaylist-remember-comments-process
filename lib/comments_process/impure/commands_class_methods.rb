# coding: utf-8

require 'command'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Impure
      module Commands
        module ClassMethods

          attr_accessor :model

          def process(commands)
            @commands = commands
            process_single until @commands.empty?
          end

          private

          def process_single
            command = @commands.shift # FIFO stack.
            unless command.empty?
              @model, commands_to_add = Command.process @model, command
              @commands.push(*commands_to_add)
            end
            nil
          end
        end
      end
    end
  end
end
