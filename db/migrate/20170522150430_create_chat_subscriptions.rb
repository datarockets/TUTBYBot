class CreateChatSubscriptions < ActiveRecord::Migration
  def change
    create_table :chat_subscriptions do |t|
      t.datetime :archived_at

      t.timestamps
    end

    add_reference :chat_subscriptions, :chat
  end
end
