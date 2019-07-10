json.extract! account, :id, :name, :surname, :address, :mobile_number, :created_at, :updated_at
json.url account_url(account, format: :json)
