module Notifiable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :notifiable, dependent: :destroy
  end

  def create_notification(options)
    message = options[:message]
    user_id = options[:user_id]
    self.notifications.create({ message: message, user_id: user_id })
  end

end