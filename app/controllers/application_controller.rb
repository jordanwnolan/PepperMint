class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def publish_shares
    current_user.publish_shares
  end

  def publish_share(options)
    # fail
    if options[:item]
      item = options[:item]
      is_new = options[:is_new]
      item.create_public_share( { user_id: current_user.id, is_new: is_new } )
    end
  end

  def current_user
    return nil if session[:token].nil?
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def signed_in?
    !!current_user
  end

  def login_user(user)
    @current_user = user
    session[:token] = user.reset_session_token!
  end

  def logout_user
    current_user.try(:reset_session_token!)
    session[:token] = nil
  end

  def require_signed_in!
    redirect_to root_url unless signed_in?
  end
end
