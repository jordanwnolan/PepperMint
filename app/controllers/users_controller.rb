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
      login_user(@user)
      redirect_to(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    unless @message
      @message = @user.received_messages.new
    end
    @already_following = current_user.followed_users.include?(@user)
    received_messages = @user.received_messages
    .where(sender_id: current_user.id).order(:created_at).first(10)

    sent_messages = @user.sent_messages
    .where(receiver_id: current_user.id).order(:created_at).first(10)

    @messages = received_messages + sent_messages

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

  def fame
    item = Share.find(params[:share_id]).shareable
    share_id = params[:share_id]
    item.fames.create({value: 1, 
      user_receiving_fame_id: params[:id], 
      user_giving_fame_id: current_user.id, 
      share_id: share_id })
    redirect_to feed_url
  end

  def shame
    item = Share.find(params[:share_id])
    share_id = params[:share_id]
    item.fames.create({value: -1, user_receiving_fame_id: params[:id], user_giving_fame_id: current_user.id,
      share_id: share_id })
    redirect_to feed_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :avatar)
  end

  def profile_params
    params.require(:profile).permit(:age, :gender, :zip_code)
  end
end
