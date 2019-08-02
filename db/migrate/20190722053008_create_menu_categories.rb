class CreateMenuCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_categories do |t|
      t.string :name, null:false
    end
  end
end
