class ChangeAgeBaseToMetabolism < ActiveRecord::Migration[5.0]
  def change
    change_column :metabolisms, :base_metabolic_standard, :float
    change_column :metabolisms, :base_weight, :float
  end
end
