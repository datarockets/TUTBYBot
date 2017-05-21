class RemoveTelegramIds < ActiveRecord::Migration
  def change
    remove_column :users, :telegram_id, :integer
    remove_column :chats, :telegram_id, :integer
  end
end
