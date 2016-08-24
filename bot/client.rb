require 'telegram/bot'
require 'telegram/bot/botan'
require_relative '../config/config'
require_relative 'action'

module Bot
  class Client
    def initialize(token = nil, botan_token = nil)
      @token = token || Config::TOKEN
      @botan_token = botan_token || Config::BOTAN_TOKEN
    end

    def start
      Telegram::Bot::Client.run(@token) do |bot|
        bot.enable_botan!(@botan_token)

        bot.listen do |user_message|
          Bot::Action.new(
            bot: bot,
            user_message: user_message
          ).run
        end
      end
    end
end
