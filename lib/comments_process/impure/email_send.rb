# coding: utf-8

require 'email_send_class_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Impure
      module EmailSend
        extend ::QplaylistRememberCommentsProcess::CommentsProcess::Impure::EmailSend::ClassMethods
      end
    end
  end
end
