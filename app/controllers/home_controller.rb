class HomeController < ApplicationController
  before_action :require_signed_in!, except: [:home]
  def home
  end

  def overview
    @budgets = current_user.budgets
    @goals = current_user.goals
  end
end
