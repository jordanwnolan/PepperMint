class TransactionCategory < ActiveRecord::Base
  validates :description, presence: true

  has_many :merchant_categories
  has_many :transactions, through: :merchant_categories, source: :transactions
end
