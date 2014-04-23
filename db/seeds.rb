# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

jordan = User.create({email: "jordan", password: "123456", username: "jordan"})
chelesa = User.create({email: "chelsea", password: "123456", username: "chelsea"})  
stewart = User.create({email: "stewart", password: "123456", username: "stewart"})
martha = User.create({email: "martha", password: "123456", username: "martha"})

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

c1 = chelsea.accounts.create({bank_id: gnb.id, 
  account_username: 'chelsea', 
  account_password: '123456', 
  account_name: 'Lots o Money Checking',
  balance: 7000,
  account_type: 0})
c2 = chelsea.accounts.create({bank_id: evil.id, 
  account_username: 'chelsea', 
  account_password: '123456', 
  account_name: 'Will Not Take Your Savings',
  balance: 8000,
  account_type: 1})
c3 = chelsea.accounts.create({bank_id: bofa.id, 
  account_username: 'chelsea', 
  account_password: '123456', 
  account_name: 'Too Much Credit Card',
  balance: 3000,
  account_type: 2})
c4 = chelsea.accounts.create({bank_id: evil.id, 
  account_username: 'chelsea', 
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

j1.transactions.create([{}])
