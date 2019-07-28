class Food < ApplicationRecord
  belongs_to :menu
  has_many :food_eatings
end
