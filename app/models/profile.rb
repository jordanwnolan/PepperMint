class Profile < ActiveRecord::Base

  belongs_to :user, inverse_of: :profile
end
