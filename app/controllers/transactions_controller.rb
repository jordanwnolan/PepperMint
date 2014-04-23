class TransactionsController < ApplicationController
  def index
    @accounts = current_user.accounts
    @transactions = current_user.transactions.includes(:merchant_category)
  end
end
