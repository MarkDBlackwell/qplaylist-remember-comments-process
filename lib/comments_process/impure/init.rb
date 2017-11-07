# coding: utf-8

require 'model'
require 'my_file'

module ::CommentsProcess
  module Impure
    module Init
      module ClassMethods

        def run
# Keep first:
          ::Dir.chdir Pure::MyFile.folder_volatiles
# Keep alphabetized:
          configuration_load
          current_time_initialize
          email_sent_count_initialize
# Keep last:
          model
        end

        private

        def configuration_load
          configuration_read
          model_keys = %i[
              email_address_daemon
              email_password_daemon
              schedule_source
              ]
          configuration_names = model_keys.map{|e| "qplaylist_rcp_#{e}".upcase}
          configuration_values = configuration_names.map{|e| ::ENV[e]}.compact
          values_all_have      = configuration_values.none?{|e| e.empty?}
          length_good          = configuration_values.length == model_keys.length
          unless length_good && values_all_have
            print "Missing (at least one of) environment variables #{configuration_names.join ', '}.\n"
            raise
          end
          (model_keys.zip configuration_values).each{|k,v| model[k] = v}
          nil
        end

        def configuration_read
          ::File.open Pure::MyFile.filename_environment_file, 'r' do |f|
            list = f.readlines.map{|e| e.chomp}
            list.each do |line|
              token_count_per_line_expected = 2
              a = (line.split '=').map{|e| e.strip}
              raise unless a.length == token_count_per_line_expected
              name, value = a
              ::ENV[name] = value
            end
          end
          nil
        end

        def current_time_initialize
#         model[:current_time] = ::Time.new 2018, 6, 13, 7, 15
          model[:current_time] = ::Time.now
          nil
        end

        def email_sent_count_initialize
          model[:email_sent_count] = 0
        end

        def model
           @model_value ||= Model.new
        end
      end

      extend ::CommentsProcess::Impure::Init::ClassMethods
    end
  end
end
