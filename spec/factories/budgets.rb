# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :budget do
    frequency 2
    frequency_reset 1
    amount 500
    category_id 1
  end
end
