class RemoveLineIdFromUserStatuses < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_statuses, :line_id, :string
  end
end
