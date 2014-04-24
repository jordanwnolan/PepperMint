class Share < ActiveRecord::Base
  belongs_to :shareable, polymorphic: true
end
