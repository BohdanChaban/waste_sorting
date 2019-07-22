class CreateTimeslots < ActiveRecord::Migration[5.2]
  def change
    create_table :timeslots do |t|
      t.datetime :start_time

      t.belongs_to :district, index: true
      t.belongs_to :user
      t.timestamps
    end
  end
end
