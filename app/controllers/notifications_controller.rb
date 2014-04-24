class NotificationsController < ApplicationController
  after_action :mark_as_read

  def index
    @notifications = current_user.notifications.includes(:notifiable).where(viewed: false)
  end

  private

  def mark_as_read
    current_user.notifications.where(viewed: false).update_all({viewed: true})
  end
end
