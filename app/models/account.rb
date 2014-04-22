class Account < ActiveRecord::Base
  validates(
    :account_username,
    :account_password,
    presence: true
    )

  belongs_to :user
  belongs_to :bank
  
end
