class UsersController < ApplicationController
    before_action :require_user!, only: %i(show)

    def index
        @users = User.all
    end
    
    def new
        @user = User.new
    end
    
    def show
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            # to do: change to goals page
            login_user!(@user)
            render :index
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new 
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end

end
