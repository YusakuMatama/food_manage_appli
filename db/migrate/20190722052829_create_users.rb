class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :user_statuses do |t|
      t.string     :name
      t.string     :age
      t.string     :gender
      t.string     :weight
      t.string     :active_level
      t.string     :est_energy_req
      t.string     :line_id
      t.references  :metabolism, foreign_key: true  
      t.references  :user, foreign_key: true  
      t.timestamps null: true
    end
  end
end
