class AccountsController < ApplicationController
  before_action :require_signed_in!
  def new
    @banks = Bank.all
    @account = current_user.accounts.new
  end

  def create
    @account = current_user.accounts.new(account_params)

    if @account.save
      redirect_to accounts_url
    else
      @banks = Bank.all
      flash.now[:errors] = @account.errors.full_messages
      render :new
    end
  end

  def index
    @accounts = current_user.accounts.includes(:bank)
  end

  def show
    # fail
    @accounts = current_user.accounts
    @account = current_user.accounts.where(id: params[:id]).first

    if @account
      @transactions = @account.transactions.includes(:merchant_category, :account).order(date: :desc)
      if request.xhr?
        render partial: 'transactions/transactions', locals: { transactions: @transactions }
      end
    else
      flash[:errors] = ["You are not authorized to view this account"]
      redirect_to accounts_url
    end
  end

  def choose
    if params[:account][:id] == '0'
      redirect_to transactions_url
    else
      redirect_to account_url(Integer(params[:account][:id]))
    end
  end

  private

  def account_params
    params
    .require(:account)
    .permit(:account_username, :account_password, :account_name, :bank_id, :account_type)
  end

end
