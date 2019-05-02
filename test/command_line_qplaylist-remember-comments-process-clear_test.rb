# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require_relative 'command_line_test_helper'

module ::QplaylistRememberCommentsProcess
  module CommandLine
    class QplaylistRememberCommentsProcessClearTest < QplaylistRememberCommentsProcessCommandLineTest

      def stub_things
        ::          QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :filename_comments,         filename_comments                 do
          ::        QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :filename_environment_file, filename_environment_file_fixture do
            ::      QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :filename_log,              filename_output_log               do
              ::    QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :folder_data_applications,  folder_data_applications          do
                ::  QplaylistRememberCommentsProcess::CommentsProcess::Pure::MyFile.stub :folder_data_own,           folder_data_own                   do
                  ::Time.stub                                                            :now,                       time_now                          do
                    yield
                  end
                end
              end
            end
          end
        end
        nil
      end
    end
  end
end
