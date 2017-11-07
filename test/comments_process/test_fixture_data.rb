# coding: utf-8

require 'period_record'

module ::CommentsProcess
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
