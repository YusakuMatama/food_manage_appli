class CreateMetabolisms < ActiveRecord::Migration[5.0]
  def change
    create_table :metabolisms do |t|
      t.string      :age_base
      t.string      :gender
      t.string      :base_metabolic_standard
      t.string      :base_weight
      t.string      :base_metabolic_rate
      t.timestamps
    end
  end
end
