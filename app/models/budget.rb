class Budget < ActiveRecord::Base
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

  def self.frequencies
    {0 => 'Daily',
     1 => 'Weekly',
     2 => 'Monthly'}
  end

  def self.frequency_resets
    {0 => [],
     1 => ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
     2 => ['First of Month', '15th of Month', 'End of Month']
   }
  end

  def self.reset_day
    { 1 => :beginning_of_month,
      2=> :end_of_month }
  end

  def current_transactions
    self.transactions.where("date >= ?", get_reset_date)
  end

  def progress

    applicable_transactions = current_transactions.all

    applicable_transactions.inject(0) { |accum, transactions| accum += transactions.amount }
  end

  def on_track?
    progress < self.amount
  end

  def set_date_beginning_of_week
    Date.beginning_of_week = case self.frequency_reset
    when 0
      :monday
    when 1
      :tuesday
    when 2
      :wednesday
    when 3
      :thursday
    when 4
      :friday
    when 5
      :saturday
    when 6
      :sunday
    end
  end

  def get_reset_date
    today = Date.current

    if self.frequency == 0
      reset_date = today.yesterday
    elsif self.frequency == 1
      set_date_beginning_of_week
      reset_date = today.next_week.last_week #finds the last reset without going too far back
    else

      reset_day = get_reset_day(today)

      if reset_day > today.day
        last_month = today.prev_month
        reset_date = last_month.change(day: get_reset_day(last_month))
      else
        reset_date = today.change(day: reset_day)
      end
    end

    reset_date
  end

  private

  def get_reset_day(date)
    if self.frequency_reset >= 1
      reset_day = date.send(Budget.reset_day[self.frequency_reset]).day
    else
      reset_day = 15
    end
  end

end
