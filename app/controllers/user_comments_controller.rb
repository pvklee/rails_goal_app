class UserCommentsController < ApplicationController
    before_action :require_user!, only: %i(create)

    def create
        @user_comment = current_user.authored_user_comments.new(user_comment_params)
        if @user_comment.save
            flash[:notices] = ['Comment saved!']
        else
            flash[:errors] = @user_comment.errors.full_messages
        end

        redirect_back fallback_location: users_url
    end

    private
    def user_comment_params
        params.require(:user_comment).permit(:comment_text, :user_id)
    end
end
