class Chat::Subscription < ActiveRecord::Base
  belongs_to :chat

  scope :active, -> { where(archived_at: nil) }

  def archive!
    update_attribute(:archived_at, Time.current)

    puts "Subscription OFF {chat_id: #{chat_id}, archived_at: #{archived_at}}"
  end

  after_create do |subscription|
    puts "Subscription ON {chat_id: #{subscription.chat_id}, created_at: #{subscription.created_at}}"
  end
end
