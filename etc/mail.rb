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
mdb March 20, 2018 - created

For Qplaylist Remember Songs Comments Process
=end

require_relative 'methods'

module ::QplaylistRememberCommentsProcess
  include Methods

# Don't greet.

# Navigate to the project root directory:
  ::Dir.chdir project_root

# Check the periods file:
  is_tentative = true
  command_run %w[bundle exec ruby] + [filename_program_periods_check], is_tentative

  ::Kernel.exit child_status_integer unless command_ran_best

# Navigate to download files from the webserver computer:
  ::Dir.chdir directory_volatiles

  filename = filename_command_ftp 'get'

  confirm_ftp_command_file_exists filename

# Retrieve listener comments:
  argument_ftp = "-s:#{filename}"
  command_run %w[ftp] + [argument_ftp]

  ::Kernel.exit child_status_integer unless command_ran_best

# Navigate to the project root directory:
  ::Dir.chdir project_root

# Process listener comments:
  is_tentative = true
  command_run %w[bundle exec ruby] + [filename_program_mail], is_tentative

  ::Kernel.exit child_status_integer unless command_ran_best
end
