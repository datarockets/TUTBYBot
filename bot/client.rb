require 'telegram/bot'
require 'telegram/bot/botan'
require_relative '../config/secrets'
require_relative 'actions_controller'

class Client
  def initialize(token = nil, botan_token = nil)
    @token = token || Config::Secrets::TOKEN
    @botan_token = botan_token || Config::Secrets::BOTAN_TOKEN
  end

  def start
    Telegram::Bot::Client.run(@token) do |bot|
      bot.enable_botan!(@botan_token)

      bot.listen do |user_message|
        ActionsController.new(
          bot: bot,
          user_message: user_message
        ).select_action
      end
    end
  end
end
