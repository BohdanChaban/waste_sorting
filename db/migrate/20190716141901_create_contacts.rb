class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :mobile_number
      t.string :facebook
      t.string :instagram
      t.string :other_info

      t.timestamps
    end
  end
end
