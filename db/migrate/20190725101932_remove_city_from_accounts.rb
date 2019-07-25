class RemoveCityFromAccounts < ActiveRecord::Migration[5.2]
  def change
    remove_reference :accounts, :city
  end
end
