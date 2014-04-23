class GoalsController < ApplicationController

  def index
    @goals = current_user.goals
  end

  def new
    @goal = current_user.goals.new
    @accounts = current_user.accounts
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      flash[:alerts] = ['Goal created successfully']
      redirect_to @goal
    else
      @accounts = current_user.accounts
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = current_user.goals.find(params[:id])

    unless @goal
      flash[:errors] = ["You are not authorized to view this goal"]
      redirect_to overview_url
    end

    render :show
  end

  def edit
    @goal = current_user.goals.find(params[:id])
    @accounts = current_user.accounts

    unless @goal
      flash[:errors] = ["You are not authorized to view this goal"]
      redirect_to overview_url
    end

    render :edit
  end

  def update
    @goal = current_user.goals.find(params[:id])

    if @goal.update(goal_params)
      flash[:alerts] = ['Goal created successfully']
      redirect_to @goal
    else
      @accounts = current_user.accounts
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = current_user.goals.find(params[:id])

    if @goal.destroy
      flash[:alerts] = ['Goal deleted']
      redirect_to goals_url
    else
      flash[:errors] = ["You can't delete this goal"]
      redirect_to @goal
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:name, :account_id, :goal_date, :amount, :private)
  end
end
