class MessagesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @received_messages = @user.received_messages.includes(:sender)
    @sent_messages = @user.sent_messages.includes(:receiver)
  end

  def create
    # fail
    @user = User.find(params[:user_id])
    @message = @user.received_messages.new(message_params)
    @message.sender_id = current_user.id

    if @message.save
      # flash[:alerts] = ["Message sent!"]
      redirect_to @user
    else
      @already_following = current_user.followed_users.include?(@user)
      @messages = @user.received_messages.includes(:sender).where(sender_id: current_user.id).order(:created_at).first(10)

      if @user == current_user
        @budgets = @user.budgets.to_a
        @goals = @user.goals.to_a
      else
        @budgets = @user.budgets.where(private: false)
        @goals = @user.goals.where(private: false)
      end
      
      @profile = @user.profile
      render 'users/show'
    end
  end

  def destroy
    # fail
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to user_url(params[:user_id])
  end

  private

  def message_params
    params.require(:message).permit(:title, :body)
  end
end
