class User < ApplicationRecord

    has_many :transactions
    has_many :stocks, through: :transactions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
    def calc_total_balance(amount)
        self.balance = self.balance - amount
        self.save
    end       
end
