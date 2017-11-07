# coding: utf-8

require 'gmail'

module ::CommentsProcess
  module Impure
    module EmailSend
      module ClassMethods

        def email_send(model, email)
          address  = model[ :email_address_daemon]
          password = model[:email_password_daemon]
          connect_and_send email, address, password
          model[:email_sent_count] += 1
          nil
        end

        private

        def connect_and_send(email, address, password)
          ::Gmail.connect!(address, password) do |gmail|
            message = gmail.compose do
              to email.email_address_disk_jockey
              subject email.subject
              body email.body.chomp
            end
            message.deliver!
          end
          nil
        end
      end

      extend ::CommentsProcess::Impure::EmailSend::ClassMethods
    end
  end
end
