class ChangeDataLineIdToUser < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users, :line_id, :string, false
  end
end
