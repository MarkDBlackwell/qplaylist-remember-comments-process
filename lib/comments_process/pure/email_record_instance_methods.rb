# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
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
end
