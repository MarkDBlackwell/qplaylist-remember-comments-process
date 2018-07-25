# coding: utf-8

=begin
Author: Mark D. Blackwell (google me)
mdb March 26, 2018 - created
=end

require_relative 'comments_process_load_path'
require 'cycle_periods_check'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Impure
      CyclePeriodsCheck.init
      CyclePeriodsCheck.run
    end
  end
end
