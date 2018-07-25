# coding: utf-8

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Impure
      module EmailSend
        module ClassMethods

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
## Here, simply using 'self' doesn't work. (I don't know why.)
## Clue: 'self' is 'CommentsProcess::Impure::EmailSend'.
## Clue; 'CommentsProcess::Impure::EmailSend' is extended with
##   '::CommentsProcess::Impure::EmailSend::ClassMethods',
##   (rather than including it).
#-------------
           ::QplaylistRememberCommentsProcess::CommentsProcess::Impure::EmailSend::ClassMethods
          end
        end
      end
    end
  end
end
