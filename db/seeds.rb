# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

jordan = User.create({email: "jordan@appacademy.io", password: "123456", username: "jordan"})
stewart = User.create({email: "stewart@appacademy.io", password: "123456", username: "stewart"})
martha = User.create({email: "martha@appacademy.io", password: "123456", username: "martha"})
sennacy = User.create({email: "sennacy@appacademy.io", password: "123456", username: "sennacy"})

bofa = Bank.create({name: "Bank of MURICA", url: "USAUSA.com"})
gnb = Bank.create({name: "Goliath National Bank", url: "gnb.com"})
evil = Bank.create({name: "Totally Not Evil Bank", url: "evil.com"})

j1 = jordan.accounts.create({bank_id: gnb.id, 
  account_username: 'jordan', 
  account_password: '123456', 
  account_name: 'Lots o Money Checking',
  balance: 20000,
  account_type: 0})
j2 = jordan.accounts.create({bank_id: gnb.id, 
  account_username: 'jordan', 
  account_password: '123456', 
  account_name: 'Big Time Savings',
  balance: 10000,
  account_type: 1})
j3 = jordan.accounts.create({bank_id: bofa.id, 
  account_username: 'jordan', 
  account_password: '123456', 
  account_name: 'Too Much Credit Card',
  balance: 5000,
  account_type: 2})

c1 = sennacy.accounts.create({bank_id: gnb.id, 
  account_username: 'sennacy', 
  account_password: '123456', 
  account_name: 'Lots o Money Checking',
  balance: 7000,
  account_type: 0})
c2 = sennacy.accounts.create({bank_id: evil.id, 
  account_username: 'sennacy', 
  account_password: '123456', 
  account_name: 'Will Not Take Your Savings',
  balance: 8000,
  account_type: 1})
c3 = sennacy.accounts.create({bank_id: bofa.id, 
  account_username: 'sennacy', 
  account_password: '123456', 
  account_name: 'Too Much Credit Card',
  balance: 3000,
  account_type: 2})
c4 = sennacy.accounts.create({bank_id: evil.id, 
  account_username: 'sennacy', 
  account_password: '123456', 
  account_name: 'Way Too Much Credit Card',
  balance: 7000,
  account_type: 2})

m1 = martha.accounts.create({bank_id: bofa.id, 
  account_username: 'martha', 
  account_password: '123456', 
  account_name: 'Too Much Credit Card',
  balance: 1000,
  account_type: 2})
m2 = martha.accounts.create({bank_id: gnb.id, 
  account_username: 'martha', 
  account_password: '123456', 
  account_name: 'A Little Credit Card',
  balance: 2000,
  account_type: 2})

s1 = stewart.accounts.create({bank_id: bofa.id, 
  account_username: 'stewart', 
  account_password: '123456', 
  account_name: 'Little Savings',
  balance: 3000,
  account_type: 1})
s2 = stewart.accounts.create({bank_id: gnb.id, 
  account_username: 'stewart', 
  account_password: '123456', 
  account_name: 'A Little Credit Card',
  balance: 1000,
  account_type: 2})

t1 = TransactionCategory.create({description: "Food and Entertainment"})
t2 = TransactionCategory.create({description: "Car"})
t3 = TransactionCategory.create({description: "Health and Fitness"})
t4 = TransactionCategory.create({description: "Commute"})
t5 = TransactionCategory.create({description: "Rent/Mortgage"})
t6 = TransactionCategory.create({description: "Finance Charge"})

MerchantCategory.create({merchant_category_code: 1000, merchant_category: "Grocery", transaction_category_id: t1.id})
MerchantCategory.create({merchant_category_code: 2000, merchant_category: "Bars", transaction_category_id: t1.id})
MerchantCategory.create({merchant_category_code: 3000, merchant_category: "Restaurant", transaction_category_id: t1.id})
MerchantCategory.create({merchant_category_code: 4000, merchant_category: "Gas", transaction_category_id: t2.id})
MerchantCategory.create({merchant_category_code: 5000, merchant_category: "Smog", transaction_category_id: t2.id})
MerchantCategory.create({merchant_category_code: 6000, merchant_category: "Mechanic", transaction_category_id: t2.id})
MerchantCategory.create({merchant_category_code: 7000, merchant_category: "Transit", transaction_category_id: t3.id})
MerchantCategory.create({merchant_category_code: 8000, merchant_category: "Rent", transaction_category_id: t5.id})
MerchantCategory.create({merchant_category_code: 9000, merchant_category: "Mortgage", transaction_category_id: t5.id})
MerchantCategory.create({merchant_category_code: 10000, merchant_category: "Fee", transaction_category_id: t6.id})

merchant_categories = MerchantCategory.all.to_a
nums = (0..50).to_a
amounts = (-1000..1000).to_a
dates = (-60..0).to_a
Account.all.each do |account|
  nums.sample.times do |transaction|
    category = merchant_categories.sample
    category = category.merchant_category_code
    account.transactions.create({merchant_category_code: category, 
      date: Date.current + dates.sample,
      amount: amounts.sample})
  end
end

User.all.each do |user|

end