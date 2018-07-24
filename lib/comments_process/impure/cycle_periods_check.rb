# coding: utf-8

require 'cycle_periods_check_class_methods'

module ::CommentsProcess
  module Impure
    module CyclePeriodsCheck
      extend ::CommentsProcess::Impure::CyclePeriodsCheck::ClassMethods
    end
  end
end
