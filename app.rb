require 'rubygems'
require 'daemons'
require_relative 'bot/client'

client = Bot::Client.new
Daemons.run client.start
