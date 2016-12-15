class Transaction < ActiveRecord::Base
     belongs_to :account
     belongs_to :atm_machine
     validates_presence_of :account_id
     #validates :debit, :ammount, :presence => true
    
end
