class SessionsController < ApplicationController
  after_action :publish_shares, only: [:create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:password])
    # fail
    if @user

      login_user(@user)
      redirect_to overview_url
    else
      flash.now[:errors] = ["Invalid Credentials"]
      @user = User.new
      render :new
    end
  end

  def destroy
    logout_user
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
