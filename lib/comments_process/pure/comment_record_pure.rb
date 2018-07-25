# coding: utf-8

require 'comment_record_pure_instance_methods'

module ::CommentsProcess
  module Pure
    class CommentRecordPure

# Keep before attr_reader:
      def self.names_ordered
        %w[
            internet_protocol_address
            user_identifier
            category
            ]
      end

      attr_reader(*names_ordered)

      include ::CommentsProcess::Pure::CommentRecordPure::InstanceMethods
    end
  end
end
