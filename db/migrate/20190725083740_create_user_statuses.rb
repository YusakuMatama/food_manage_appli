class CreateUserStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_statuses do |t|
      t.string      :name, null:false
      t.integer     :age, null:false
      t.string      :gender, null:false
      t.integer     :weight
      t.integer     :est_energy_req, null:false
      t.references  :metabolism, foreign_key: true, null:false  
      t.references  :user, foreign_key: true, null:false
      t.timestamps
    end
  end
end
