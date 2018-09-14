# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'period_record'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
    class TestFixtureData

      attr_reader :value

      def initialize
        period_array = %w[
            sun
            17
            19
            bob
            bobsmith@example.com
            ]
        period_line = period_array.join ' '
        period = Pure::PeriodRecord.new period_line
        comments = ::Array.new
        data = period, comments
        @value = data
      end
    end
  end
end
