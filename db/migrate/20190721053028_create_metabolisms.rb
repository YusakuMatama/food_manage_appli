class CreateMetabolisms < ActiveRecord::Migration[5.0]
  def change
    create_table :metabolisms do |t|
      t.integer      :age_base, null:false
      t.string      :gender, null:false
      t.float      :base_metabolic_standard, null:false
      t.float      :base_weight, null:false
      t.integer      :base_metabolic_rate, null:false
      t.timestamps
    end
  end
end
