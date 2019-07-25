class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.string  :name
      t.string  :calorie
      t.string  :hiragana_name
      t.references  :menu, foreign_key: true  
      t.references  :menu_category, foreign_key: true  
      t.timestamps
    end
  end
end
