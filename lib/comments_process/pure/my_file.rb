# coding: utf-8

require 'my_file_class_methods'

module ::CommentsProcess
  module Pure
    module MyFile
      extend ::CommentsProcess::Pure::MyFile::ClassMethods
    end
  end
end
