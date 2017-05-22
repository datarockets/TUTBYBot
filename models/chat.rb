class Chat < ActiveRecord::Base
  self.inheritance_column = '_type'

  has_one :user, dependent: :destroy
  has_many :requests, dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_one :active_subscription, -> { active }, class_name: Chat::Subscription, foreign_key: :chat_id

  def has_active_subscription?
    active_subscription.present?
  end

  after_create do |chat|
    puts "Created Chat {id: #{chat.id}}"
  end
end
