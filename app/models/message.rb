class Message < ActiveRecord::Base
  attr_accessor :time_ago
  belongs_to :receiver, class_name: "User"
  belongs_to :sender, class_name: "User"

  validates :body, presence: true

end
