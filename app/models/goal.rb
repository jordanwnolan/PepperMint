class Goal < ActiveRecord::Base
  include Progress
  include Shareable
  include Fameable
  include Commentable
  
  before_create :define_monthly_amount, :set_initial_balance
  before_save :define_monthly_amount

  validates :name, :goal_date, :amount, presence: true
  validate :user, :account

  belongs_to :user
  belongs_to :account

  has_many :transactions, through: :account, source: :transactions

  def self.generate_notification_message
    "Under goal!"
  end

  def generate_message(options)
    if options[:is_new]
      "Great! #{self.user.username} just created a goal to #{self.name}"
    elsif options[:on_track]
      "Hooray! #{self.user.username} is on track to meet their goal to #{self.name}! Give them some fame!"
    else
      "Oh noes! #{self.user.username} is not on track to meet their goal to #{self.name}! Shame on them!"
    end
  end

  def current_transactions(date = self.created_at)
    self.transactions.inlcudes(:account).where("date >= ?", date).map do |transaction|
      transaction.account.account_type == 2 ? (-1 * transaction.amount) : transaction.amount
    end
  end

  def get_amounts(transactions_to_convert)
    transactions_to_convert.map do |transaction|
      transaction.account.account_type == 2 ? (-1 * transaction.amount) : transaction.amount
    end
  end

  def set_initial_balance
    self.account_initial_bal = self.account.current_balance
  end

  def define_monthly_amount
    start_date = (self.created_at ? self.created_at : Date.current)
    # debugger
    months_to_go = (self.goal_date.year * 12 + self.goal_date.month) - (start_date.year * 12 + start_date.month)
    self.monthly_amount = (amount / months_to_go.to_f).round
  end

  def overall_on_track?
    transactions_to_convert = account.transactions.includes(:account).where("date >= ?", self.created_at)
    progress(get_amounts(transactions_to_convert)) >= get_current_overall_scaled_goal_amount
  end

  def this_month_on_track?
    reset_date = get_reset_date
    reset_date = (reset_date < self.created_at ? self.created_at.to_date : reset_date)
    transactions_to_convert = account.transactions.includes(:account).where("date >= ?", reset_date)
    progress(get_amounts(transactions_to_convert)) >= get_current_scaled_monthly_amount
  end

  def on_track?
    overall_on_track? && this_month_on_track?
  end

  def overall_progress
    account.current_balance - account_initial_bal
  end

  def this_month_progress
    reset_date = get_reset_date
    reset_date = reset_date < self.created_at ? self.created_at.to_date : reset_date
    account.current_balance - self.account.balance_at_date(reset_date)
    # fail
  end

  #scale the amounts to how far into the period to check if on track
  def get_current_overall_scaled_goal_amount
    total_days = (self.goal_date - self.created_at.to_date).to_i
    days_so_far = (Date.current - self.created_at.to_date).to_i
    (self.amount * (days_so_far / total_days.to_f)).round
  end

  def get_current_scaled_monthly_amount
    reset_date = get_reset_date
    reset_date = (reset_date < self.created_at ? self.created_at.to_date : reset_date)
    total_days = (reset_date.next_month - reset_date.to_date).to_i
    days_so_far = (Date.current - reset_date).to_i
    (self.monthly_amount * (days_so_far / total_days.to_f)).round
  end
end
