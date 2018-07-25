# coding: utf-8

require 'period_record_instance_methods'

module ::CommentsProcess
  module Pure
    class PeriodRecord

# Keep before attr_reader:
      def self.names
        %i[
            email_address_disk_jockey
            hour_end
            hour_start
            name_first_disk_jockey
            weekday
            ]
      end

      attr_reader(*names)

      include ::CommentsProcess::Pure::PeriodRecord::InstanceMethods
    end
  end
end
