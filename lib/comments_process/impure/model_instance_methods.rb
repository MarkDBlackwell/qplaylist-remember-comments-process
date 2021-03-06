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
    module Impure
      class Model < ::Hash
        module InstanceMethods

          def initialize_copy(previous)
            super
            dumped = ::Marshal.dump previous
            ::Marshal.load dumped
          end
        end

        include InstanceMethods
      end
    end
  end
end
