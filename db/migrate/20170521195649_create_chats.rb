class CreateChats < ActiveRecord::Migration
  def self.up
    create_table :chats do |t|
      t.string :type
      t.string :title
      t.integer :telegram_id

      t.timestamps
    end

    add_reference :users, :chat
  end

  def self.down
    drop_table :chats
  end
end
