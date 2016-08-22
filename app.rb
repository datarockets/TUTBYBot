require "daemons"
require_relative 'lib/client'

Daemons.run('client.rb')
