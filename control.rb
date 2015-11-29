require "daemons"
require "active_support"
require_relative 'constants'
require_relative 'api'

Daemons.run('client.rb', options = { dir: '/tmp/pids', dir_mode: :normal, log_output: true })