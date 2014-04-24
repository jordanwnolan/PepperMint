class Comment < ActiveRecord::Base
  include Commentable
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User"
end
