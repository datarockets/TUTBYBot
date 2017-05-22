require 'recursive-open-struct'

class SubscriptionSender
  attr_reader :subscription

  def initialize(subscription:)
    @subscription = subscription
  end

  def send
    calculate_chat_deterministic_prediction

    send_data_to_chat
  end

  private

  def calculate_chat_deterministic_prediction
    @chat_deterministic_prediction_command =
      Chat::DeterministicPrediction.new(chat: chat).calculate
  end

  def send_data_to_chat
    Chat::Pusher.new(user_message: user_message).push
  end

  def user_message
    @_user_message ||= RecursiveOpenStruct.new(
      text: @chat_deterministic_prediction_command,
      chat: {
        id: chat.id
      }
    )
  end

  delegate :chat, to: :subscription
end
