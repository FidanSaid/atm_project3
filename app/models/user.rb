class User < ActiveRecord::Base
  has_one :account  ,dependent: :destroy
  has_one :user_info ,dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
