class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  
  helper_method :current_user
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
  
  def login_user(user)
    session[:token] = user.set_token
    @current_user = user
  end
  
  def log_out
    current_user.try(:set_token)
    session[:token] = nil
  end
  
  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_token(session[:token])
  end
  
  def require_log_in
    redirect_to new_session_url unless !!current_user
  end
end
