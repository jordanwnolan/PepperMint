require 'spec_helper'

describe Transaction do
  it { should belong_to(:account) }
  it { should belong_to(:merchant_category) }
  it { should belong_to(:merchant_category).with_foreign_key(:merchant_category_code) }

  context "Transaction::find_since_date" do
    it "should find all transactions since the given date" do
      date = Date.current.change(day: Date.current.day - 7)
      transaction = FactoryGirl.create(:transaction, date: date)
      expect(Transaction.find_since_date(date)).to eq([transaction])
    end
  end

  context "Transaction#value" do
    it "should return normal values for a savings or checking account"
    it" should return inverse values for credit cards"
  end

  context "Transaction::find_all_in_category" do
    before do
      transaction = Transaction.create(account_id: 1, merchant_category_code: 5000, description: "CHEVRON", amount: 50)
      transaction_category = TransactionCategory.create(description: "Car, Gas, Maintenance")
      merchant_category = MerchantCategory.create(merchant_category_code: 5000, merchant_category: "Gas", transaction_category_id: 2)
    end


    # it "should find all transactions in a category" do
    #   transaction = Transaction.create(account_id: 1, merchant_category_code: 5000, description: "CHEVRON", amount: 50)
    #   transaction_category = TransactionCategory.create(description: "Car, Gas, Maintenance")
    #   merchant_category = MerchantCategory.create(merchant_category_code: 5000, 
    #     merchant_category: "Gas",
    #     transaction_category_id: Integer(transaction_category.id))
    #   transaction = Transaction.create(account_id: 1, merchant_category_code: 5000, description: "CHEVRON", amount: 50)
    #   transaction_category = TransactionCategory.create(description: "Car, Gas, Maintenance")
    #   merchant_category = MerchantCategory.create(merchant_category_code: 5000, merchant_category: "Gas")
    #   expect(Transaction.find_all_in_category(transaction_category.id).first.transaction_category.description).to eq("Car, Gas, Maintenance")
    end
  end
end
