class Transaction < ActiveRecord::Base

  belongs_to :account
  belongs_to(
    :merchant_category, 
    foreign_key: :merchant_category_code,
    primary_key: :merchant_category_code)

  delegate :transaction_category, to: :merchant_category

  def self.find_since_date(date)
    Transaction.where("date >= ?", date)
  end

  def self.find_before_date(date)
    Transaction.where("date < ?", date)
  end

  def self.find_all_in_category(id)
    Transaction.includes(merchant_category: :transaction_category)
    .references(:transaction_category)
    .select { |transaction| transaction.transaction_category.id == id }
  end

end
