class Share < ActiveRecord::Base
  include Fameable
  belongs_to :shareable, polymorphic: true
  belongs_to :user
end
