# coding: utf-8

module ::CommentsProcess
  module Pure
    class EmailRecord
      module InstanceMethods

        def initialize(email_address_disk_jockey,  body,  name_first_disk_jockey,  subject)
                      @email_address_disk_jockey, @body, @name_first_disk_jockey, @subject =
                       email_address_disk_jockey,  body,  name_first_disk_jockey,  subject
        end

        def ==(other)
          self.class.names.all?{|e| (other.send e) == (self.send e)}
        end

        def inspect
          [
              @name_first_disk_jockey,
              @subject,
              @email_address_disk_jockey,
              @body,
          ].join "\n"
        end

        def to_s
          '' # During test development, avoid puzzlement.
        end
      end
    end
  end
end
