# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'gmail'
require 'logger_module_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Impure
      module EmailSend
        module ModuleMethods

          def email_send(model, email)
#print 'email='; pp email
            params = varying_ordered.map{|e| model[:"email_#{e}_daemon"]}
            connect_and_send email, *params

#           connect_and_send(*[
#               email,
#               'email-daemon@example.com',
#               'email-reply-to-daemon@example.com',
#               'email-daemon-password',
#               ])
            model[:email_sent_count] += 1
            nil
          end

          private

          def connect_and_send(email, address, address_reply_to, password)
            begin
            ::Gmail.connect!(address, password) do |gmail|
              message = gmail.compose do
                reply_to address_reply_to
                to email.email_address_disk_jockey
                subject email.subject
                body email.body.chomp
              end
              message.deliver!
            end
            rescue => exception
              Logger.log_write "Gmail::Client: #{exception.message}"
              raise
            end
            nil
          end

          def varying_ordered
            %w[
                address
                address_reply_to
                password
                ]
          end
        end

        extend ModuleMethods
      end
    end
  end
end
