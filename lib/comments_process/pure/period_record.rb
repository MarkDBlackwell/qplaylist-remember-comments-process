# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'period_record_instance_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Pure
      class PeriodRecord

# Keep before attr_reader:
        def self.names
          %i[
              email_address_disk_jockey
              hour_end
              hour_start
              name_first_disk_jockey
              weekday
              ]
        end

        attr_reader(*names)

        include InstanceMethods
      end
    end
  end
end
