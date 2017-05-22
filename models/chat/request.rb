require 'enumerize'

class Chat::Request < ActiveRecord::Base
  extend Enumerize

  self.inheritance_column = '_type'

  belongs_to :chat

  enumerize :type, in: %i(currencies news top search)

  after_create do |request|
    puts "Created Request {type: #{request.type}, payload: #{request.payload}, chat_id: #{request.chat_id}, created_at: #{request.created_at.to_time.strftime('%H:%M %Y-%m-%d')}}"
  end
end
