class ChangeDataAgeBaseToMetabolism < ActiveRecord::Migration[5.0]
  def change
    change_column :metabolisms, :age_base, :integer
    change_column :metabolisms, :base_metabolic_standard, :integer
    change_column :metabolisms, :base_weight, :integer
    change_column :metabolisms, :base_metabolic_rate, :integer
  end
end
