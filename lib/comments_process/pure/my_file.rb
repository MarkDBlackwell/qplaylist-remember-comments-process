# coding: utf-8

require 'my_file_class_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Pure
      module MyFile
        extend ::QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile::ClassMethods
      end
    end
  end
end
