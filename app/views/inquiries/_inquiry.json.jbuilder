json.extract! inquiry, :id, :status, :created_at, :updated_at
json.url inquiry_url(inquiry, format: :json)
