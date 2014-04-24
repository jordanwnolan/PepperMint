class Goal < ActiveRecord::Base
  include Progress
  include Shareable
  include Fameable
  
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
    self.transactions.where("date >= ?", date)
  end

  def set_initial_balance
    self.account_initial_bal = self.account.current_balance
  end

  def define_monthly_amount
    start_date = (self.created_at ? self.created_at : Date.current)
    months_to_go = (self.goal_date.year * 12 + self.goal_date.month) - (start_date.year * 12 + start_date.month)
    self.monthly_amount = (amount / months_to_go.to_f).round
  end

  def overall_on_track?
    progress(account.transactions.where("date >= ?", self.created_at)) >= get_current_overall_scaled_goal_amount
  end

  def this_month_on_track?
    progress(account.transactions.where("date >= ?", get_reset_date)) >= get_current_scaled_monthly_amount
  end

  def on_track?
    overall_on_track? && this_month_on_track?
  end

  def overall_progress
    account.current_balance - account_initial_bal
  end

  def this_month_progress
    account.current_balance - self.account.balance_at_date(get_reset_date)
  end

  #scale the amounts to how far into the period to check if on track
  def get_current_overall_scaled_goal_amount
    total_days = (self.goal_date - self.created_at.to_date).to_i
    days_so_far = (Date.current - self.created_at.to_date).to_i
    (self.amount * (days_so_far / total_days.to_f)).round
  end

  def get_current_scaled_monthly_amount
    reset_date = get_reset_date
    total_days = (reset_date.next_month - reset_date.to_date).to_i
    days_so_far = (Date.current - reset_date).to_i
    (self.monthly_amount * (days_so_far / total_days.to_f)).round
  end
end
