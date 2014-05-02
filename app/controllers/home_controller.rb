class HomeController < ApplicationController
  before_action :require_signed_in!, except: [:home]

  def home
    redirect_to overview_url if current_user
  end

  def overview
    @transactions = current_user.transactions.includes(:merchant_category)
    @transactions_by_month = @transactions.group_by_month(:date, format: "%B %Y").sum(:amount)
    @budgets = current_user.budgets
    @goals = current_user.goals
  end

  def feed
    @shares = Share.
    all.includes(:user, :fames, shareable: { comments: :author } )
    .where("created_at >= ? AND user_id != ?", Date.current.prev_month,current_user.id)
    .order(created_at: :desc)

    @all = true
    # fail
    if request.xhr?
      render partial: 'home/feed', locals: { shares: @shares }
    else
      render :feed
    end
  end

  def followed_feed
    ids = current_user.followed_users.map { |user| user.id }
    @shares = Share.where(user_id: ids).where("created_at >= ?", Date.current.prev_month)
    .includes(:user, :fames, shareable: { comments: :author }).order(created_at: :desc)

    @all = false

    if request.xhr?
      render partial: 'home/feed', locals: { shares: @shares }
    else
      render :feed
    end
  end

  def fame
    # fail
  end

  def shame

  end
end
