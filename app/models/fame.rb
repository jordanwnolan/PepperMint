class Fame < ActiveRecord::Base
  belongs_to :user_giving_fame, class_name: "User", foreign_key: :user_giving_fame_id, primary_key: :id
  belongs_to :user_receiving_fame, class_name: "User", foreign_key: :user_receiving_fame_id, primary_key: :id
  belongs_to :fameable, polymorphic: true
  belongs_to :share
end
