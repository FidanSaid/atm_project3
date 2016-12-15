json.extract! transaction, :id, :debit, :amount, :merchandise_name, :account_id, :atm_machine_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)