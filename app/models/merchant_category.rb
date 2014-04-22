class MerchantCategory < ActiveRecord::Base
  validates :merchant_category_code, :merchant_category, presence: true

  belongs_to :transaction_category

  has_many :transactions, class_name: "Transaction", foreign_key: :merchant_category_code, primary_key: :merchant_category_code
end
