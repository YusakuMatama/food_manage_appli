class MenuCategory < ApplicationRecord
  has_many :food_eating
  has_many :foods
end
