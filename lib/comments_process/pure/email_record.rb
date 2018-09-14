# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'email_record_instance_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Pure
      class EmailRecord

# Keep before attr_reader:
        def self.names
          %i[
              body
              email_address_disk_jockey
              name_first_disk_jockey
              subject
              ]
        end

        attr_reader(*names)

        include InstanceMethods
      end
    end
  end
end
