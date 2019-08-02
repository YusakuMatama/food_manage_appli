class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.string  :name, null:false
      t.integer  :calorie, null:false
      t.string  :hiragana_name, null:false
      t.references  :menu, foreign_key: true, null:false  
      t.references  :menu_category, foreign_key: true, null:false  
      t.timestamps
    end
  end
end
