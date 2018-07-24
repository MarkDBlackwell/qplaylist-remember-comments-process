# coding: utf-8

require 'logger_class_methods'

module ::CommentsProcess
  module Impure
    module Logger
      extend ::CommentsProcess::Impure::Logger::ClassMethods
    end
  end
end
