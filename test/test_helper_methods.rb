# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

module ::QplaylistRememberCommentsProcess
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

      def expected_filename_output_log
        filename_fixture_shared 'log.txt'
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

      def filename_environment_file_fixture
        filename_fixture_shared 'environment-file.txt'
      end

      def filename_fixture(basename)
        ::File.join folder_testbed, 'fixture', basename
      end

      def filename_fixture_shared(basename)
        ::File.join folder_shared, 'fixture', basename
      end

      def filename_output_log
        filename_volatile 'log.txt'
      end

      def filename_schedule_source
        filename_fixture_shared 'RememberSongsSchedule.txt'
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

      def folder_shared
        ::File.join dirname_script_this, 'shared'
      end

      def folder_testbed
        ::File.join dirname_script_this, program_prefix
      end

      def impure_init_define
        check_ancestors = false
        unless CommentsProcess         .const_defined? :Impure, check_ancestors
               CommentsProcess         .const_set      :Impure, Module.new
        end
        unless CommentsProcess::Impure .const_defined? :Init,   check_ancestors
               CommentsProcess::Impure .const_set      :Init,   Module.new
        end
      end

      def model
        CommentsProcess::Impure::Init.instance_variable_get :@model_value
      end

      def model_clear
        impure_init_define
        value = nil
        CommentsProcess::Impure::Init.instance_variable_set :@model_value, value
      end

      def time_now
        ::Time.new 2018, 6, 5, 14, 15
      end
    end

    extend InstanceMethods
  end
end
