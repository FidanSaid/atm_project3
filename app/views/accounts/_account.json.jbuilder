json.extract! account, :id, :account_number, :account_id, :balance, :status, :created_at, :updated_at
json.url account_url(account, format: :json)