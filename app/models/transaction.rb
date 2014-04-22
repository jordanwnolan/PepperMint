class Transaction < ActiveRecord::Base

  belongs_to :account
  belongs_to(
    :merchant_category, 
    foreign_key: :merchant_category_code,
    primary_key: :merchant_category_code)
end
