class TransactionsController < ApplicationController
  def index
    @accounts = current_user.accounts
    @transactions = current_user.transactions.includes(:account, merchant_category: :transaction_category).order(date: :desc)
    @data = data_for_transaction_categories(@transactions)
    if request.xhr?
      render partial: 'transactions/transactions', locals: { transactions: @transactions.limit(50), data: @data }
    else
      render :index
    end
  end

  def edit
    @transaction = current_user.transactions.find(params[:id])
    @categories = MerchantCategory.all
  end

  def update
    @transaction = current_user.transactions.find(params[:id])

    if @transaction.update(transaction_params)
      if request.xhr?
        render partial: 'transactions/transaction', locals: { transaction: @transaction }
      else
        flash[:alerts] = ['Transaction updated successfully']
        redirect_to transactions_url
      end
    else
      flash.now[:errors] = @transaction.errors.full_messages
      render :edit
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:merchant_category_code, :description)
  end

  def data_for_transaction_categories(transactions)
    data = Hash.new { |h, k| h[k] = 0 }
    
    debits =  transactions.reject do |transaction| 
      transaction.merchant_category_code == DEPOSIT_CODE || transaction.merchant_category_code == PAYMENT_CODE
    end

    debits.each do |transaction|
      if  transaction.account.account_type == 2
       data[transaction.merchant_category.transaction_category.description] += transaction.amount
     else
        data[transaction.merchant_category.transaction_category.description] -= transaction.amount
      end
      # fail
    end

    # fail
    data.to_a
  end
end
