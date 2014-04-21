class UsersController < ApplicationController
  before_action :require_signed_in!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @profile = Profile.new(user_id: @user.id)
      redirect_to(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def edit
    @user = current_user
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:id])
    @profile = @user.profile

    if @user.update(user_params)
      @profile.update(profile_params)
      redirect_to(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      flash.now[:errors] += @profile.errors.full_messages if @profile.errors
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :picture_url)
  end

  def profile_params
    params.require(:profile).permit(:age, :gender, :zip_code)
  end
end
