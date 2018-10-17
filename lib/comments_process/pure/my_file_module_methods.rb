# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    module Pure
      module MyFile
        module ModuleMethods

          def file_lines(filename)
            ::File.open filename, 'r' do |f|
              return f.readlines.map(&:chomp)
            end
          end

          def filehandle_echo
            $stdout
          end

          def filehandle_input_user
            $stdin
          end

          def filehandle_prompt
            $stdout
          end

          def filename_comments
            ::File.join folder_volatiles, 'comments.txt'
          end

          def filename_dump
            ::File.join folder_dump, 'dump.txt'
          end

          def filename_environment_file
            ::File.join folder_data_own, 'environment-file.txt'
          end

          def filename_log
            ::File.join folder_volatiles, 'log.txt'
          end

          def folder_data_own
            ::File.join folder_data_applications, basename_own
          end

          def folder_etc
            ::File.join project_root, 'etc'
          end

          def folder_volatiles
            ::File.join folder_data_own, 'var'
          end

          private

          def basename_own
            '.qplaylist-remember-comments-process'
          end

          def dirname_script_this
            ::Kernel.__dir__
          end

          def folder_data_applications
            ::File.realpath ::ENV['APPDATA']
          end

          def folder_dump
            ::File.join project_root, *%w[test shared var]
          end

          def project_root
            pure = dirname_script_this
            target = ::File.join pure, *['..']*3
            ::File.realpath target
          end
        end
      end
    end
  end
end
