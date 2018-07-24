# coding: utf-8

require 'email_send_class_methods'

module ::CommentsProcess
  module Impure
    module EmailSend
      extend ::CommentsProcess::Impure::EmailSend::ClassMethods
    end
  end
end
