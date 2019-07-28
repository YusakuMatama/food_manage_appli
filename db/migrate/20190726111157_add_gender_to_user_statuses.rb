class AddGenderToUserStatuses < ActiveRecord::Migration[5.0]
  def change
    add_column :user_statuses, :gender, :string
  end
end
