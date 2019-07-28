class ChangeEstEnergyReqToUserStatuses < ActiveRecord::Migration[5.0]
  def change
    change_column :user_statuses, :est_energy_req, :integer
  end
end
