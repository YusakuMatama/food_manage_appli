class CreateFoodEatings < ActiveRecord::Migration[5.0]
  def change
    create_table :food_eatings do |t|
      t.references  :food, foreign_key: true      
      t.references  :user, foreign_key: true      
      t.timestamps
    end
  end
end
