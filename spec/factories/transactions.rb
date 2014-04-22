# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    account_id 1
    merchant_category_code 5000
    description "CHEVRON"
    amount 50
  end
end
