class Share < ActiveRecord::Base
  belongs_to :shareable, polymorphic: true
  belongs_to :user
end
