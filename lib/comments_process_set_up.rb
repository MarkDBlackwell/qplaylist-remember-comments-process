# coding: utf-8

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
