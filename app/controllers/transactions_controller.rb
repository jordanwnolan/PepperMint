class TransactionsController < ApplicationController
  def index
    @accounts = current_user.accounts
    @transactions = current_user.transactions.includes(:merchant_category).order(date: :desc)

    if request.xhr?
      render partial: 'transactions/transactions', locals: { transactions: @transactions }
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
end
