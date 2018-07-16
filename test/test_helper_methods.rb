# coding: utf-8

module ::CommentsProcess
  module Impure
    module Init
    end
  end
end

module ::QplaylistRememberCommentsProcessTest
  module TestHelperMethods
    module InstanceMethods

      private

      def assert_equal_file_content(expected_filename, actual_filename)
        ::   File.open expected_filename, 'r' do |f_exp|
          :: File.open   actual_filename, 'r'   do |f_act|
            expected, actual = [f_exp, f_act].map(&:readlines)
            assert_equal expected, actual
          end
        end
        nil
      end

      def assert_equal_filename_filehandle_content(expected_filename, actual_filehandle)
        actual = filehandle_read actual_filehandle
        ::File.open expected_filename, 'r' do |f_exp|
          expected = f_exp.readlines
          assert_equal expected, actual
        end
        nil
      end

      def basename_own
        '.qplaylist-remember-comments-process'
      end

      def dirname_script_this
        ::Kernel.__dir__
      end

      def file_clear(filename)
        ::File.open(filename, 'w'){}
        nil
      end

      def file_touch(filename)
        ::File.open(filename, 'a'){}
        nil
      end

      def filehandle_read(filehandle)
        filehandle.rewind
        filehandle.readlines
      end

      def filename_environment_file
        ::File.join folder_data_applications, basename_own, 'environment-file.txt'
      end

      def filename_fixture(basename)
        ::File.join folder_testbed, 'fixture', basename
      end

      def filename_output_log
        filename_volatile 'log.txt'
      end

      def filename_volatile(basename)
        ::File.join folder_testbed, 'var', basename
      end

      def folder_data_applications
        ::File.join folder_testbed, 'appdata'
      end

      def folder_data_own
        folder_testbed
      end

      def folder_own
        ::File.join folder_data_applications, basename_own
      end

      def folder_testbed
        ::File.join dirname_script_this, program_prefix
      end

      def model_clear
        ::CommentsProcess::Impure::Init.instance_variable_set :@model_value, nil
      end

      def time_now
        ::Time.new 2018, 6, 5, 14, 15
      end
    end

    include TestHelperMethods::InstanceMethods
  end
end
