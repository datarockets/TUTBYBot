require 'rubygems'
require 'daemons'
require_relative 'lib/client'

client = Client.new
Daemons.run client