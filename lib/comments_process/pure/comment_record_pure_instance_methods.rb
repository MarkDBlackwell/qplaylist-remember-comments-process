# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'my_time_module_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Pure
      class CommentRecordPure
        module InstanceMethods

          attr_reader :rest
          attr_reader :timestamp

          def initialize(line)
            all = parse_input line
            initialize_ever_present all
            @timestamp = ymdhm.map{|e| instance_variable_get :"@#{e}"}.join ' '
            @rest = all.drop(ever_present_count).join ' '
          end

          private

          def ever_present_count
             ever_present_fields.length
          end

          def ever_present_fields
            ymdhm + names_ordered
          end

          def initialize_ever_present(all)
            values = all.take ever_present_count
            ever_present_fields.zip(values).each{|name,value| instance_variable_set :"@#{name}", value}
          end

          def names_ordered
            self.class.names_ordered
          end

          def parse_input(line)
            all = line.split ' '
            raise unless all.length > ever_present_count
            all
          end

          def ymdhm
            Pure::MyTime.ymdhm
          end
        end

        include InstanceMethods
      end
    end
  end
end
