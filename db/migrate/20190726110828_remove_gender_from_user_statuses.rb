class RemoveGenderFromUserStatuses < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_statuses, :gender, :string
  end
end
