class AddDistrictsToAccounts < ActiveRecord::Migration[5.2]
  def change
  	add_reference :accounts, :district, foreign_key: true
  end
end
