# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require_relative '../test_helper_methods'

module ::QplaylistRememberCommentsProcess
  module CommandLine
    module TestHelperMethods
      module InstanceMethods

        private

        def directory_exe
          ::File.join project_root, 'exe'
        end

        private

        def dirname_script_this
          ::Kernel.__dir__
        end

        def project_root
          @project_root_value ||= begin
            prefix = ::File.join '..', '..'
            ::File.realpath prefix, dirname_script_this
          end
        end
      end

      extend InstanceMethods
    end
  end
end
