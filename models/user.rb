class User < ActiveRecord::Base
  belongs_to :chat
  has_many :user_requests, dependent: :destroy
end
