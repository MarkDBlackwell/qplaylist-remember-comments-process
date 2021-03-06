# coding: utf-8

=begin
Copyright (C) 2018 Mark D. Blackwell.
   All rights reserved.
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
=end

=begin
 See:
https://github.com/gmailgem/gmail
https://github.com/nfo/gmail_xoauth
=end

require 'gmail'

module TryGmailGemModule
  module TryGmailGemMethods

    def configuration_initialize(names)
      config_read
      names.map{|e| ::ENV[e]}
    end

    def config_read
      ::File.open 'environment-file.txt', 'r' do |f|
        list = f.readlines.map(&:chomp)
        separator = '='
        list.each do |line|
          a = line.split separator
          name = a.first.strip
          value = a.drop(1).join(separator).strip
          ::ENV[name] = value
        end
      end
    end
  end

  class TryGmailGem
    include TryGmailGemMethods

    def run
      config_names = %w[
          qplaylist_remember_songs_mail_password
          qplaylist_remember_songs_mail_username
          ].map(&:upcase)
      password_account_mail, username_account_mail = configuration_initialize config_names
      ::Gmail.connect!(username_account_mail, password_account_mail) do |gmail|
        email = gmail.compose do
          to 'name@gmail.com'
          subject 'Having fun in Puerto Rico!'
          body 'Spent the following day on the road...'
        end
        email.deliver!
      end
    end
  end
end

::TryGmailGemModule::TryGmailGem.new.run
