# coding: utf-8

require 'my_file'

module ::CommentsProcess
  module Impure
    module SetUp
      module ClassMethods

        def init
          @configuration_hash = interact
          @approval_obtained = verification_ask_for
          nil
        end

        def run
          if @approval_obtained
            folders_create
            environment_file_fill @configuration_hash
            ftp_file_create @configuration_hash
            closing_message
          end
          nil
        end

        private

        def closing_message
          Pure::MyFile.filehandle_prompt.print "Success. Hit Enter to close.\n"
          Pure::MyFile.filehandle_input_user.gets
          nil
        end

        def configuration_get
          keys_ordered = %i[
              domain_ftp
              username_ftp
              password_ftp
              email_address_daemon
              email_password_daemon
              email_address_reply_to_daemon
              schedule_source
              ]
          keys_ordered_prompt = [
              'FTP domain',
              'FTP username',
              'FTP password',
              'email daemon\'s address',
              'email daemon\'s password',
              'email daemon\'s reply-to address',
              'schedule file (full path)',
              ]
          result = ::Hash.new
          keys_ordered.zip(keys_ordered_prompt).each do |key, key_prompt|
            Pure::MyFile.filehandle_prompt.print "#{prompt_prefix}What is your #{key_prompt}?\n"
            response = Pure::MyFile.filehandle_input_user.gets.chomp
            Pure::MyFile.filehandle_echo.print "#{response}\n\n"
            result.store key, response
          end
          result
        end

        def configuration_print(hash)
          Pure::MyFile.filehandle_prompt.print "#{prompt_prefix}Check these values:\n\n"
          key_length_max = hash.keys.map(&:to_s).map(&:length).max
          spaces_to_add_min = 3
          hash.each do |key, value|
            spaces_to_add = spaces_to_add_min + key_length_max - key.length
            Pure::MyFile.filehandle_echo.print "#{key}:#{' '*spaces_to_add}#{value}\n\n"
          end
          nil
        end

        def environment_file_fill(hash)
          filename = ::File.join Pure::MyFile.folder_data_own, 'environment-file.txt'
          ::File.open filename, 'w' do |f|
          blocked_keys = %i[
              domain_ftp
              password_ftp
              username_ftp
              ]
            hash.sort.each do |key, value|
              unless blocked_keys.include? key
                full = "qplaylist_rcp_#{key}".upcase
                f.print "#{full}=#{value}\n"
              end
            end
          end
          nil
        end

        def folder_create(dirname)
          unless ::Dir.exist? dirname
            ::Dir.mkdir dirname
          end
          nil
        end

        def folders_create
          node_lists = [[], %w[var]]
          branches = node_lists.map{|a| ::File.join Pure::MyFile.folder_data_own, *a}
          branches.each{|e| folder_create e}
          nil
        end

        def ftp_file_create(hash)
          %w[
              delete
              get
              ].each do |action|
            filename = ::File.join Pure::MyFile.folder_data_own, "comments-#{action}.ftp"
            ::File.open filename, 'w' do |f|
              f.print "open #{hash[:domain_ftp  ]}\n"
              f.print "#{     hash[:username_ftp]}\n"
              f.print "#{     hash[:password_ftp]}\n"
              ftp_file_partial(action).each{|e| f.print "#{e}\n"}
            end
          end
          nil
        end

        def ftp_file_partial(action)
          basename = "comments-#{action}-partial.ftp"
          filename = ::File.realpath basename, Pure::MyFile.folder_etc
          Pure::MyFile.file_lines filename
        end

        def interact
          Pure::MyFile.filehandle_prompt.print "\n#{prompt_prefix}Type Ctrl-C to cancel (at any time).\n"
          result = configuration_get
          configuration_print result
          result
        end

        def prompt_prefix()
          ' '*7
        end

        def verification_ask_for
          Pure::MyFile.filehandle_prompt.print "\n#{prompt_prefix}Are all of these values correct?\n"
          Pure::MyFile.filehandle_prompt.print   "#{prompt_prefix}Hit Enter to approve, or C to cancel.\n"
          line = Pure::MyFile.filehandle_input_user.gets
          first_character = line.strip.downcase.slice 0..0
          exit_desired = 'c' == first_character
          !exit_desired
        end
      end
    end
  end
end
