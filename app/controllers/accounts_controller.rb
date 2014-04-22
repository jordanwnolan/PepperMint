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

  private

  def account_params
    params
    .require(:account)
    .permit(:account_username, :account_password, :account_name, :bank_id)
  end
end
