require 'active_support/concern'

module Progress
  extend ActiveSupport::Concern

  def progress(current_transactions)
    current_transactions.inject(0) { |accum, transactions| accum += transactions.amount }
  end

  def set_date_beginning_of_week(frequency_reset)
    Date.beginning_of_week = case frequency_reset
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

  def get_reset_date(frequency = 2, frequency_reset = 0)
    today = Date.current

    if frequency == 0
      reset_date = today.yesterday
    elsif frequency == 1
      set_date_beginning_of_week(frequency_reset)
      reset_date = today.next_week.last_week #finds the last reset without going too far back
    else

      reset_day = get_reset_day(frequency_reset, today)
      # debugger
      if reset_day >= today.day
        last_month = today.prev_month
        reset_date = last_month.change(day: get_reset_day(frequency_reset, last_month))
        # debugger
      else
        reset_date = today.change(day: reset_day)
      end
    end

    reset_date
  end

  private

  def get_reset_day(frequency_reset, date)
    if frequency_reset >= 1
      reset_day = date.send(Budget.reset_day[self.frequency_reset]).day
    else
      reset_day = 15
    end
  end
end