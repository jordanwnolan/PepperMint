class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.includes(:notifiable).where(viewed: false)
  end

  def show
    @notification = Notification.find(params[:id])
    mark_as_read(@notification)
    redirect_to @notification.url
  end

  private

  def mark_as_read(notification)
    notification.update({viewed: true})
  end
end
