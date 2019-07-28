class UserStatus < ApplicationRecord
  has_many :metabolisms
  belongs_to :user
  
end
