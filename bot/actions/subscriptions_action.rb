require 'require_all'
require_all 'services'

class Actions::SubscriptionsAction < Actions::BaseAction
  def handle_subscription
    if chat.has_active_subscription?
      turn_off_subscription
    else
      turn_on_subscription
    end
  end

  private

  def turn_off_subscription
    chat.active_subscription.archive!

    basic_response "subscription_off"
  end

  def turn_on_subscription
    chat.subscriptions.create

    basic_response "subscription_on"
  end

  def chat
    @_chat ||= Chat.find(@id)
  end
end
