require 'rubygems'
require 'daemons'
require_relative 'bot/client'

client = Client.new
Daemons.run client.start
