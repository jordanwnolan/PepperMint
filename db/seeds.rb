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
ned = User.create({email: "ned@appacademy.io", password: "123456", username: "ned"})
jonathan = User.create({email: "jonathan@appacademy.io", password: "123456", username: "jonathan"})

bofa = Bank.create({name: "Bank of America", url: "bofa.com"})
gnb = Bank.create({name: "Wells Fargo", url: "wellsfargo.com"})
evil = Bank.create({name: "Chase", url: "chase.com"})

charge_accounts = [];
credit_cards = [];
savings_accounts = [];

j1 = jordan.accounts.create({bank_id: gnb.id, 
  account_username: 'jordan', 
  account_password: '123456', 
  account_name: 'Wells Fargo Checking',
  balance: 20000,
  account_type: 0})
j2 = jordan.accounts.create({bank_id: gnb.id, 
  account_username: 'jordan', 
  account_password: '123456', 
  account_name: 'Wells Fargo Savings',
  balance: 10000,
  account_type: 1})
j3 = jordan.accounts.create({bank_id: bofa.id, 
  account_username: 'jordan', 
  account_password: '123456', 
  account_name: 'Bank of America Credit Card',
  balance: 5000,
  account_type: 2})

charge_accounts << j1
charge_accounts << j3
savings_accounts << j2
credit_cards << j3

c1 = ned.accounts.create({bank_id: gnb.id, 
  account_username: 'ned', 
  account_password: '123456', 
  account_name: 'Wells Fargo Checking',
  balance: 7000,
  account_type: 0})
c2 = ned.accounts.create({bank_id: evil.id, 
  account_username: 'ned', 
  account_password: '123456', 
  account_name: 'Chase Savings',
  balance: 8000,
  account_type: 1})
c3 = ned.accounts.create({bank_id: bofa.id, 
  account_username: 'ned', 
  account_password: '123456', 
  account_name: 'Bank of America Credit Card',
  balance: 3000,
  account_type: 2})
c4 = ned.accounts.create({bank_id: evil.id, 
  account_username: 'ned', 
  account_password: '123456', 
  account_name: 'Chase Credit Card',
  balance: 7000,
  account_type: 2})

charge_accounts << c1
charge_accounts << c3
charge_accounts << c4
savings_accounts << c2

credit_cards << c3
credit_cards << c4

m1 = martha.accounts.create({bank_id: bofa.id, 
  account_username: 'martha', 
  account_password: '123456', 
  account_name: 'Bank of America Savings',
  balance: 1000,
  account_type: 1})
m2 = martha.accounts.create({bank_id: gnb.id, 
  account_username: 'martha', 
  account_password: '123456', 
  account_name: 'Wells Fargo Checking',
  balance: 2000,
  account_type: 0})

charge_accounts << m2
savings_accounts << m1

s1 = stewart.accounts.create({bank_id: bofa.id, 
  account_username: 'stewart', 
  account_password: '123456', 
  account_name: 'Bank of America Savings',
  balance: 3000,
  account_type: 1})
s2 = stewart.accounts.create({bank_id: gnb.id, 
  account_username: 'stewart', 
  account_password: '123456', 
  account_name: 'Wells Fargo Credit Card',
  balance: 1000,
  account_type: 2})

charge_accounts << s2
savings_accounts << s1
credit_cards << s2

t1 = TransactionCategory.create({description: "Food and Entertainment"})
t2 = TransactionCategory.create({description: "Car"})
t3 = TransactionCategory.create({description: "Health and Fitness"})
t4 = TransactionCategory.create({description: "Commute"})
t5 = TransactionCategory.create({description: "Rent/Mortgage"})
t6 = TransactionCategory.create({description: "Finance Charge"})
t7 = TransactionCategory.create({description: "Deposit"})
t8 = TransactionCategory.create({description: "Payment"})

m1 = MerchantCategory.create({merchant_category_code: 1000, merchant_category: "Grocery", transaction_category_id: t1.id})
m2 = MerchantCategory.create({merchant_category_code: 2000, merchant_category: "Bars", transaction_category_id: t1.id})
m3 = MerchantCategory.create({merchant_category_code: 3000, merchant_category: "Restaurant", transaction_category_id: t1.id})
m4 = MerchantCategory.create({merchant_category_code: 4000, merchant_category: "Gas", transaction_category_id: t2.id})
m5 = MerchantCategory.create({merchant_category_code: 5000, merchant_category: "Smog", transaction_category_id: t2.id})
m6 = MerchantCategory.create({merchant_category_code: 6000, merchant_category: "Mechanic", transaction_category_id: t2.id})
m7 = MerchantCategory.create({merchant_category_code: 7000, merchant_category: "Transit", transaction_category_id: t3.id})
m8 = MerchantCategory.create({merchant_category_code: 8000, merchant_category: "Rent", transaction_category_id: t5.id})
m9 = MerchantCategory.create({merchant_category_code: 9000, merchant_category: "Mortgage", transaction_category_id: t5.id})
m10 = MerchantCategory.create({merchant_category_code: 10000, merchant_category: "Fee", transaction_category_id: t6.id})
m11 = MerchantCategory.create({merchant_category_code: 11000, merchant_category: "Deposit", transaction_category_id: t7.id})
m12 = MerchantCategory.create({merchant_category_code: 12000, merchant_category: "Payment", transaction_category_id: t8.id})

grocery_descriptions = ['Trader Joes', 'Save Mart', 'Whole Foods', 'The Food Emporium']
bar_descriptions = ["Dempsy's", "Phebe's", "The Wren", "McSorley's Old Ale House", "Brady's"]
restaurant_descriptions = ["Mighty Quinn's", "Ray's Pizza", "Zachary's Pizza", "McDonald's", "Burger King"]
gas_descriptions = ["Exxon", "Arco", "Shell", "Chevron"]
transit_descriptions = ["New Jersey Transit", "LIRR", "Port Authority New York", "Metropolitan Transportation Authority"]
fee_descriptions = ["Interest", "Late Fee"]

merchant_categories = [m1, m2, m3, m4, m7, m10]

descriptions = {
  m1 => grocery_descriptions,
  m2 => bar_descriptions,
  m3 => restaurant_descriptions,
  m4 => gas_descriptions,
  m7 => transit_descriptions,
  m10 => fee_descriptions
}

nums = (200..400).to_a
amounts = (-50..0).to_a
dates = (-365..0).to_a
charge_accounts.each do |account|
  nums.sample.times do |transaction|
    category = merchant_categories.sample
    description = descriptions[category].sample
    category = category.merchant_category_code
    amount = account.account_type == 2 ? (-1 * amounts.sample) : amounts.sample
    account.transactions.create({merchant_category_code: category, 
      date: Date.current + dates.sample,
      amount: amount,
      description: description})
  end
end

amounts = (8..10).to_a
credit_cards.each do |account|

  balances = account.transactions.group_by_month(:date).sum(:amount)
  balances.each do |date, balance|
      account.transactions.create({merchant_category_code: m12.merchant_category_code, 
      date: date.to_date.change(day: 15),
      amount: (-1 * (balance * ( amounts.sample / 10))),
      description: "Payment"})
  end
end

diffs= (0..12).to_a
today = Date.current
amounts = (1000..1500).to_a
checking_accounts = Account.all.where(account_type: 0)
(checking_accounts + savings_accounts).each do |account|
  diffs.each do |diff|
      account.transactions.create({ merchant_category_code: m11.merchant_category_code, 
      date: diff.months.ago.beginning_of_month.to_date,
      amount: amounts.sample,
      description: "Deposit" })

  end
end

pcts = (1..25).to_a

