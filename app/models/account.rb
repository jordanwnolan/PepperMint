class Account < ActiveRecord::Base
  validates :account_username, :account_password, presence: true
  validate :user, :bank

  belongs_to :user
  belongs_to :bank
  has_many :transactions
  
end
