# coding: utf-8

require 'model_instance_methods'

module ::CommentsProcess
  module Impure
    class Model < ::Hash
      include InstanceMethods
    end
  end
end
