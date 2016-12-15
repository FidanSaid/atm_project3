class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions
  validates_presence_of :user_id
  validates :balance, :numericality => { greater_than_or_equal_to: 0 }
#=========================================================================  
  attr_accessor :amount
#==========================================================================   
  def deposit(a)
    t = (Time.now-6.hours).beginning_of_day 
    if a[:amount].to_f  <= 0.0 
      self.errors[:base] << "Opps! Can Not Be Negative Or Empty"
      return false
    else
      if ((Transaction.where("account_id =? and created_at>=? and debit=?",id,t,true).sum(:amount).to_f)+a[:amount].to_f) > 1000
        return false
      else
        self.balance = balance.to_f + a[:amount].to_f
        self.save   
        return true
      end              
    end 
  end
#========================================================================================   
  def withdrawal(a)  
    t = (Time.now-6.hours).beginning_of_day
    if a[:amount].to_f <= 0.0
      self.errors[:base] << "Opps!Can Not Be Negative Or Empty"
      return false
    else  
      if ((Transaction.where("account_id =? and created_at>=? and debit=?",id,t,false).sum(:amount).to_f)+a[:amount].to_f) > 500
        return false 
      else
        self.balance = balance.to_f - a[:amount].to_f
        self.save        
        return true
      end
    end
  end
#===============================================================================
end
