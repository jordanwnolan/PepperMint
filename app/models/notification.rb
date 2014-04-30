class Notification < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :notifiable, polymorphic: true

  def url
    item = self.notifiable
    case self.notifiable_type
    when "Budget"
      budget_url(item)
    when "Goal"
      goal_url(item)
    when "Fame"
      item.url
    end
  end

  def default_url_options
    options = {}
    options[:host] = Rails.env.production? ? "appacademy.io" : "localhost:3000"
    options
  end
end
