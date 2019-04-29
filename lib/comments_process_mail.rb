# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require_relative 'comments_process_load_path'
require 'cycle_mail'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Impure
      CycleMail.init
      CycleMail.run
    end
  end
end
