# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

=begin
Author: Mark D. Blackwell (google me)
mdb March 19, 2018 - created
=end

require_relative 'comments_process_load_path'
require 'set_up'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Impure
      SetUp.init
      SetUp.run
    end
  end
end
