class Comment < ActiveRecord::Base
  include Commentable
  validates :body, presence: true
  validate :author
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User"
end
