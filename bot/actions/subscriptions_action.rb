require 'require_all'
require_all 'services'

class Actions::SubscriptionsAction < Actions::BaseAction
  def handle_subscription
    if chat.has_active_subscription?
      chat.active_subscription.archive!

      basic_response "subscription_off"
    else
      chat.subscriptions.create

      basic_response "subscription_on"
    end
  end

  private

  def chat
    @_chat ||= Chat.find(@id)
  end
end
