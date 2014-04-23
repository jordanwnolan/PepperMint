class Budget < ActiveRecord::Base
  include Progress
  validates :frequency, :frequency_reset, :amount, presence: true
  validate :user
  validate :transaction_category

  belongs_to :user
  belongs_to(
    :transaction_category,
    class_name: 'TransactionCategory',
    foreign_key: :category_id,
    primary_key: :id
  )

  has_many :transactions, through: :transaction_category, source: :transactions

  def self.reset_day
    { 1 => :beginning_of_month,
      2=> :end_of_month }
  end

  def current_transactions
    self.transactions.where("date >= ?", get_reset_date(self.frequency, self.frequency_reset))
  end

  def on_track?(progress)
    progress < self.amount
  end
end
