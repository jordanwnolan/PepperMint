class Account < ActiveRecord::Base
  validates :account_username, :account_password, presence: true
  validate :user, :bank

  belongs_to :user
  belongs_to :bank
  has_many :transactions
  
  def current_balance
    all_transactions = self.transactions.to_a
    all_transactions.inject(0) { |accum, transaction| accum += transaction.amount }
  end

  def balance_at_date(date)
    all_transactions = self.transactions.where("date <= ?", date).to_a
    all_transactions.inject(0) { |accum, transaction| accum += transaction.amount }
  end
end
