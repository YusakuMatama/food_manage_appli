class RemoveActiveLevelFromUserStatuses < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_statuses, :active_level, :integer
  end
end
