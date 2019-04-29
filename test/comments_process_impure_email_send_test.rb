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
    module Impure
      module EmailSend
        module ModuleMethods

## Keep before attr_reader:
          def self.names_ordered_test
            a = %w[
                email
                address
                address_reply_to
                password
                ]
            a.map{|e| :"#{e}_test"}
          end

          attr_reader(*names_ordered_test)

          def connect_and_send(*args)
            a = my_self.names_ordered_test
            a.zip(args).each do         |name,   arg|
              instance_variable_set :"@#{name}", arg
            end
          end

          private

          def my_self
## Here, simply using 'self' doesn't work. (I don't know why.) Clues:
## 1. self is QplaylistRememberCommentsProcess::CommentsProcess::Impure::EmailSend.
## 2. EmailSend is extended with ClassMethods (rather than including it).
#-------------
            ClassMethods
          end
        end
      end
    end
  end
end
