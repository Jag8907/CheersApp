class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :require_log_in, except: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def new
    redirect_to user_url(current_user) if current_user
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      login_user(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
end
