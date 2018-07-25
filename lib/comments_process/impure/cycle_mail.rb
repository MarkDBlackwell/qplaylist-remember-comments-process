# coding: utf-8

require 'cycle_mail_class_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Impure
      module CycleMail
        extend ::QplaylistRememberCommentsProcess::CommentsProcess::Impure::CycleMail::ClassMethods
      end
    end
  end
end
