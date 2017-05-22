require 'telegram/bot'
require 'telegram/bot/botan'
require_relative '../../config/secrets'
require_relative '../../bot/actions_controller'

class Chat::Pusher
  attr_reader :user_message

  def initialize(user_message:)
    @user_message = user_message
  end

  def push
    Telegram::Bot::Client.run(token) do |bot|
      bot.enable_botan!(botan_token)

      ActionsController.new(
        bot: bot,
        user_message: user_message
      ).select_action
    end
  end

  private

  def token
    Config::Secrets::TOKEN
  end

  def botan_token
    Config::Secrets::BOTAN_TOKEN
  end
end
