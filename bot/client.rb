require 'telegram/bot'
require 'telegram/bot/botan'
require_relative '../config/config'
require_relative 'action'

module Bot
  class Client
    def initialize(token = nil, botan_token = nil)
      self.token = token
      self.botan_token = botan_token
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

    private

      def token=(value)
        @token = value || Config::TOKEN
      end

      def botan_token=(value)
        @botan_token = value || Config::BOTAN_TOKEN
      end

  end
end
