class Budget < ActiveRecord::Base
  include Progress
  include Shareable
  include Fameable
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

  def self.generate_notification_message
    "Overbudget!"
  end

  def generate_message(options)
    # fail

    if options[:is_new]
      msg = "Nice! #{self.user.username} just created a new budget for: #{self.transaction_category.description}!"
    elsif options[:on_track]
      msg = "Yay! #{self.user.username} is under their #{self.transaction_category.description} budget! Give them some fame!"
    else
      msg = "Oh no! #{self.user.username} is over ther #{self.transaction_category.description} budget! Shame on them!"
    end

    msg
  end

  def name
    self.transaction_category.description
  end

  def self.reset_day
    { 1 => :beginning_of_month,
      2=> :end_of_month }
  end

  def current_transactions
    self.transactions.where("date >= ?", get_reset_date(self.frequency, self.frequency_reset))
  end

  def on_track?
    progress(current_transactions) < self.amount
  end
end
