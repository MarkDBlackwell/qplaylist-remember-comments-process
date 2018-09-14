# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

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
