class Chat < ActiveRecord::Base
  self.inheritance_column = '_type'

  has_one :user, dependent: :destroy
end
