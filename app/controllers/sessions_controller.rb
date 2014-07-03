class SessionsController < ApplicationController
  
  def new
    redirect_to user_url(current_user) if current_user
  end
  
  def create
    @user = User.find_by(user_params)
    if @user
      login_user(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end
  
  def destroy
    log_out
    redirect_to new_session_url
  end
end
