class HomeController < ApplicationController
  before_action :require_signed_in!, except: [:home]

  def home
    redirect_to overview_url if current_user
  end

  def overview
    @budgets = current_user.budgets
    @goals = current_user.goals
  end

  def feed
    @shares = Share.
    all.includes(:user, :fames, shareable: { comments: :author } )
    .where("created_at >= ? AND user_id != ?", Date.current.prev_month,current_user.id)
    .order(created_at: :desc)
  end

  def followed_feed
    ids = current_user.followed_users.map { |user| user.id }
    @shares = Share.where(user_id: ids).where("created_at >= ?", Date.current.prev_month)
    .includes(:user, :fames, shareable: { comments: :author }).order(created_at: :desc)
  end

  def fame
    # fail
  end

  def shame

  end
end
