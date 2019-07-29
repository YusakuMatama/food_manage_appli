class Food < ApplicationRecord
  has_many :food_eatings
  belongs_to :menu
  belongs_to :menu_category

end
