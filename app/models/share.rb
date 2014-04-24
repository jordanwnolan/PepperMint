class Share < ActiveRecord::Base
  # include Fameable
  include Notifiable
  belongs_to :shareable, polymorphic: true
  belongs_to :user
  has_many :fames

  def total_fame
    self.fames.sum(:value)
  end

  def name
    self.message
  end
end
