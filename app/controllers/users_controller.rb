class UsersController < ApplicationController
  before_action :require_signed_in!, except: [:new, :create]

  def new
    @user = User.new
  end

  def index
    @users = User.all.includes(:profile).where("id != ?", current_user.id)
    @current_followed_users = current_user.followed_users.to_a
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @profile = Profile.new(user_id: @user.id)
      @profile.save
      login_user(@user)
      redirect_to(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @already_following = current_user.followed_users.include?(@user)

    if @user == current_user
      @budgets = @user.budgets.to_a
      @goals = @user.goals.to_a
    else
      @budgets = @user.budgets.where(private: false)
      @goals = @user.goals.where(private: false)
    end
    
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

  def follow_user
    @user = User.find(params[:id])
    Follow.create( {follower_id: current_user.id, followed_id: @user.id} )
    redirect_to @user
  end

  def unfollow_user
    @user = User.find(params[:id])
    follow = Follow.find_by(follower_id: current_user.id, followed_id: @user.id)
    follow.destroy
    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :picture_url)
  end

  def profile_params
    params.require(:profile).permit(:age, :gender, :zip_code)
  end
end
