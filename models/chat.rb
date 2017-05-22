class Chat < ActiveRecord::Base
  self.inheritance_column = '_type'

  has_one :user, dependent: :destroy
  has_many :requests, dependent: :destroy

  after_create do |chat|
    puts "Created Chat {id: #{chat.id}}"
  end
end
