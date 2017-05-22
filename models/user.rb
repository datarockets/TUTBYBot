class User < ActiveRecord::Base
  belongs_to :chat

  after_create do |user|
    puts "Created User {id: #{user.id}, first_name: #{user.first_name}, last_name: #{user.last_name}, username: #{user.username}}"
  end
end
