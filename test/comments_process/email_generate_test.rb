# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require_relative '../test_helper'
require_relative 'email_generate_test_instance_methods'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    class EmailGenerateTest < QplaylistRememberCommentsProcessTest
      include InstanceMethods
    end
  end
end
