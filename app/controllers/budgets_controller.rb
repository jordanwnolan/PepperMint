class BudgetsController < ApplicationController
  def index
    @budgets = current_user.budgets.includes(:transaction_category)
  end

  def new
    @budget = current_user.budgets.new
    @categories = TransactionCategory.all
  end

  def create
    # fail
    @budget = current_user.budgets.new(budget_params)

    if @budget.save
      redirect_to budgets_url
    else
      flash.now[:errors] = @budget.errors.full_messages
      @categories = TransactionCategory.all
      render :new
    end
  end

  def show
    @budget = current_user.budgets.includes(:transaction_category).where(id: params[:id]).first

    unless @budget
      flash[:errors] = ["You are not authorized to view this budget"]
      redirect_to root_url
    end
  end

  private

  def budget_params
    params
    .require(:budget)
    .permit(
      :category_id, 
      :frequency, 
      :frequency_reset,
      :amount,
      :private)
  end
end
