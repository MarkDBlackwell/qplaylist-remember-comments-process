# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require_relative 'methods'

module ::QplaylistRememberCommentsProcess
  module CommandLine
    extend Methods
    extend self

    def altered_for_testing
      print greeting_at_opening # Greet.

      filename = filename_command_ftp 'delete'

      confirm_ftp_command_file_exists filename

      "-s:#{filename}"
    end
  end
end
