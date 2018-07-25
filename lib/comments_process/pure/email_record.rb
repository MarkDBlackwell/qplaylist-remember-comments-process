# coding: utf-8

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
