# coding: utf-8

require 'cycle_mail_class_methods'

module ::CommentsProcess
  module Impure
    module CycleMail
      extend ::CommentsProcess::Impure::CycleMail::ClassMethods
    end
  end
end
