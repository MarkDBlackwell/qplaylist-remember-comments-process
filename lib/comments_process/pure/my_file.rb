# coding: utf-8

module ::CommentsProcess
  module Pure
    module MyFile
      module ClassMethods

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

        def project_root
          pure = dirname_script_this
          target = ::File.join pure, '..', '..', '..'
          ::File.realpath target
        end
      end

      extend ::CommentsProcess::Pure::MyFile::ClassMethods
    end
  end
end
