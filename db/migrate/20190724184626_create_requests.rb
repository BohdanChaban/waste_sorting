class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :status, null: false, default: 0
      t.belongs_to :timeslot, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
