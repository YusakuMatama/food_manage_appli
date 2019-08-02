class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :user_status, dependent: :destroy
  has_many :food_eatings,dependent: :destroy
  has_one :metabolism

  validates :line_id, presence: { message: "でidを取得し、入力してください。" }

end
