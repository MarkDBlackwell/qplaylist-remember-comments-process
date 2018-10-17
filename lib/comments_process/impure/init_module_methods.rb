# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

require 'logger'
require 'model'
require 'my_file'

module ::QplaylistRememberCommentsProcess
  module CommentsProcess
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
# Keep alphabetized:
            model_keys = %i[
                email_address_daemon
                email_address_reply_to_daemon
                email_password_daemon
                schedule_source
                ]
            configuration_names = model_keys.map{|e| "qplaylist_rcp_#{e}".upcase}
            configuration_values = configuration_names.map{|e| ::ENV[e]}.compact
            values_all_have      = configuration_values.none?(&:empty?)
            length_good          = configuration_values.length == model_keys.length
            unless length_good && values_all_have
              message = "In environment file, missing (at least one of) environment variables: #{configuration_names.join ', '}.\n"
              Logger.crash message
            end
            model_keys.zip(configuration_values).each{|k,v| model[k] = v}
            nil
          end

          def configuration_read
            ::File.open Pure::MyFile.filename_environment_file, 'r' do |f|
              list = f.readlines.map(&:chomp)
              list.each do |line|
                token_count_per_line_expected = 2
                a = line.split('=').map(&:strip)
                token_count = a.length
                unless token_count == token_count_per_line_expected
                  message = "Bad environment file token count (#{token_count}) in line: \`#{line}'. There should be exactly #{token_count_per_line_expected} tokens.\n"
                  Logger.crash message
                end
                name, value = a
                ::ENV[name] = value
              end
            end
            nil
          end

          def current_time_initialize
#           model[:current_time] = ::Time.new 2018, 6, 13, 7, 15
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
      end
    end
  end
end
