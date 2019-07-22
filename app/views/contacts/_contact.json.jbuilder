json.extract! contact, :id, :address, :email, :mobile_number, :facebook, :instagram, :other_info, :created_at, :updated_at
json.url contact_url(contact, format: :json)
