class UserStatus < ApplicationRecord
  has_many :metabolisms
  belongs_to :user

  validates :name, presence: true
  validates :age, numericality: :only_integer 
  validates :gender, presence: true
  validates :est_energy_req, presence: true

end
