# coding: utf-8

module ::CommentsProcess
  module Impure
    class Model < Hash

      def initialize_copy(previous)
        super
        dumped = ::Marshal.dump previous
        ::Marshal.load dumped
      end
    end
  end
end
