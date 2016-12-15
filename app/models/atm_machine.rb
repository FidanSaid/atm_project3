class AtmMachine < ActiveRecord::Base
  has_many :transactions
  geocoded_by :address
  after_validation :geocode
  validates :address, :presence => true
    def show
      session[:my_atm] = @atm_machine.id
    end
end
