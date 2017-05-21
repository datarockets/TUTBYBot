require 'rubygems'
require 'daemons'
require 'active_record'
require_relative 'bot/client'

db_config = YAML::load(File.open('config/database.yml'))['default']
ActiveRecord::Base.establish_connection(db_config)

client = Client.new
Daemons.run client.start
