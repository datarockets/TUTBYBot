require 'telegram/bot'
require 'telegram/bot/botan'
require_relative '../config/secrets'
require_relative 'actions_controller'

require 'require_all'
require_all 'services'

class Client
  def initialize(token = nil, botan_token = nil)
    @token = token || Config::Secrets::TOKEN
    @botan_token = botan_token || Config::Secrets::BOTAN_TOKEN
  end

  def start
    Telegram::Bot::Client.run(@token) do |bot|
      bot.enable_botan!(@botan_token)
      begin
        bot.listen do |user_message|
          FindOrCreateChatWithUser.new(
            chat_params: user_message.chat,
            user_params: user_message.from
          ).call

          ActionsController.new(
            bot: bot,
            user_message: user_message
          ).select_action
        end
      rescue Telegram::Bot::Exceptions::ResponseError => e
        retry
      end
    end
  end
end
