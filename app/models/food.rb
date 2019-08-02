class Food < ApplicationRecord
  has_many :food_eatings
  belongs_to :menu
  belongs_to :menu_category

  validates :name, presence: true
  validates :calorie, numericality: :only_integer
  validates :hiragana_name, presence: true, format: { with: /\A[\p{hiragana}\p{blank}ー－]+\z/}

end
