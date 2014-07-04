class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end
  
  def create
    @goal = Goal.new(goal_params)
    @goal.public ||= false # default on table?
    @goal.completed ||= false ## default on table?
    @goal.user_id = params[:user_id]
   
    
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end
  
  def index
    @goals = Goal.all
  end
  
  def show
    @goal = Goal.find(params[:id])
    
    if @goal.public || current_user.id == @goal.user_id
      render 'show'
    else
      flash.now[:errors] = ["Not authorized to view goal"]
      redirect_to user_goals_url(current_user)
    end
  end
  
  def complete
    @goal = Goal.find(params[:id])
    @goal.completed = true
    @goal.save!
    
    redirect_to goal_url(@goal)
  end

  private
  
  def goal_params
    params.require(:goal).permit(:title, :completed, :public)
  end

end
