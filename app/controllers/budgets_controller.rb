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
      publish_share({ item: @budget, is_new: true }) unless @budget.private
      redirect_to budgets_url
    else
      flash.now[:errors] = @budget.errors.full_messages
      @categories = TransactionCategory.all
      render :new
    end
  end

  def show
    @budget = current_user.budgets.includes(:transaction_category).where(id: params[:id]).first
    @transactions = @budget.current_transactions

    unless @budget
      flash[:errors] = ["You are not authorized to view this budget"]
      redirect_to root_url
    end
  end

  def edit
    @budget = current_user.budgets.where(id: params[:id]).first
    @categories = TransactionCategory.all
    unless @budget
      flash[:errors] = ["You are not authorized to view this budget"]
      redirect_to root_url
    end
  end

  def update
    @budget = current_user.budgets.where(id: params[:id]).first
    if @budget.update(budget_params)
      flash[:alerts] = ["Budget updated successfully"]
      publish_share({ item: @budget }) unless @budget.private
      redirect_to budget_url(@budget)
    else
      flash.now[:errors] = @budget.errors.full_messages
      render :edit
    end
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy
    redirect_to budgets_url
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
