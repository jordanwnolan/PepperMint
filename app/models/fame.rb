class Fame < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include Notifiable
  belongs_to :user_giving_fame, class_name: "User", foreign_key: :user_giving_fame_id, primary_key: :id
  belongs_to :user_receiving_fame, class_name: "User", foreign_key: :user_receiving_fame_id, primary_key: :id
  belongs_to :fameable, polymorphic: true
  belongs_to :share

  after_create :create_notification

  def generate_notification_message
    if self.value == -1
      "#{self.user_giving_fame.username} shamed you!"
    else
      "#{self.user_giving_fame.username} gave you fame!"
    end
  end

  def create_notification
    message = self.generate_notification_message
    user_id = self.user_receiving_fame_id
    self.notifications.create({ message: message, user_id: user_id })
  end

  def name
    self.fameable.name
  end

  def url
    item = self.fameable
    case self.fameable_type
    when "Budget"
      budget_url(item)
    when "Goal"
      goal_url(item)
    end
  end

  def default_url_options
    options = {}
    options[:host] = Rails.env.production? ? "appacademy.io" : "localhost:3000"
    options
  end
end
