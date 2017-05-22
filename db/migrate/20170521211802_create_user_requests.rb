class CreateUserRequests < ActiveRecord::Migration
  def change
    create_table :chat_requests do |t|
      t.string :type
      t.string :payload

      t.timestamps
    end

    add_reference :chat_requests, :chat
  end
end
