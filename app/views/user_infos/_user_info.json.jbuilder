json.extract! user_info, :id, :first_name, :last_name, :email, :phone, :user_id, :created_at, :updated_at
json.url user_info_url(user_info, format: :json)