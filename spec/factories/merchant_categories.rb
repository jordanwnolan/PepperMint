# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :merchant_category do
    merchant_category_code 5000
    merchant_category "Gas"
  end
end
