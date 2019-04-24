class GoalCommentsController < ApplicationController
    before_action :require_user!, only: %i(create)

    def create
        @goal_comment = current_user.authored_goal_comments.new(goal_comment_params)
        if @goal_comment.save
            flash[:notices] = ['Comment saved!']
        else
            flash[:errors] = @goal_comment.errors.full_messages
        end

        redirect_back fallback_location: users_url
    end

    private
    def goal_comment_params
        params.require(:goal_comment).permit(:comment_text, :goal_id)
    end
end
