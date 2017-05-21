require 'require_all'
require_all 'models'

class FindOrCreateChatWithUser
  attr_reader :chat_params, :user_params

  def initialize(chat_params:, user_params:)
    @chat_params = chat_params
    @user_params = user_params
  end

  def call
    find_or_create_chat

    find_or_create_user
  end

  private

  def find_or_create_chat
    Chat.find_or_create_by(id: chat_params.id) do |chat|
      chat.title = chat_params.title
      chat.type = chat_params.type
    end
  end

  def find_or_create_user
    User.find_or_create_by(id: user_params.id) do |user|
      user.first_name = user_params.first_name
      user.last_name = user_params.last_name
      user.username = user_params.username
      user.chat = find_or_create_chat
    end
  end
end
