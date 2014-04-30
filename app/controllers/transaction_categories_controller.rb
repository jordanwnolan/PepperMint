class TransactionCategoriesController < ApplicationController

  def show
    @category = TransactionCategory.find(params[:id])
    @accounts = current_user.accounts
    @transactions = params[:account_id] ? transactions_for_account_and_category : transactions_for_category
    .joins('JOIN accounts ON accounts.id = transactions.account_id')
    .joins('JOIN merchant_categories ON merchant_categories.merchant_category_code = transactions.merchant_category_code')
    .joins('JOIN transaction_categories ON transaction_categories.id = merchant_categories.transaction_category_id')
    .includes(:merchant_category)
    .where('transaction_categories.id = ?', @category.id)
    .where('accounts.user_id = ?', current_user.id).order(date: :desc)

    if request.xhr?
      render partial: 'transactions/transactions', locals: {transactions: @transactions}
    else
      render :show
    end
  end

  private

  def transactions_for_category
    Transaction
    .joins('JOIN accounts ON accounts.id = transactions.account_id')
    .joins('JOIN merchant_categories ON merchant_categories.merchant_category_code = transactions.merchant_category_code')
    .joins('JOIN transaction_categories ON transaction_categories.id = merchant_categories.transaction_category_id')
    .includes(:merchant_category)
    .where('transaction_categories.id = ?', @category.id)
    .where('accounts.user_id = ?', current_user.id).order(date: :desc)
  end

  def transactions_for_account_and_category
    Transaction
    .joins('JOIN accounts ON accounts.id = transactions.account_id')
    .joins('JOIN merchant_categories ON merchant_categories.merchant_category_code = transactions.merchant_category_code')
    .joins('JOIN transaction_categories ON transaction_categories.id = merchant_categories.transaction_category_id')
    .includes(:merchant_category)
    .where('transaction_categories.id = ?', @category.id)
    .where('accounts.user_id = ?', current_user.id)
    .where('accounts.id = ?', params[:account_id])
    .order(date: :desc)
  end

end
