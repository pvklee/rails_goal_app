class GoalsController < ApplicationController
    before_action :require_user!, only: %i(new create show)

    def new
        @goal = Goal.new
    end
    
    def create
        @goal = current_user.goals.new(goal_params)
        if @goal.save
            redirect_to user_goal_url(current_user, @goal)
        else
            flash.now[:errors] = @goal.errors.full_messages
            render :new
        end
    end

    def show
        @goal = Goal.find(params[:id])
    end

    private
    def goal_params
        params.require(:goal).permit(:goal_title, :goal_description, :is_private, :is_completed)
    end
end
