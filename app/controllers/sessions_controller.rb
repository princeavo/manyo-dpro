class SessionsController < ApplicationController
    def register
        @user = User.new
        render "sessions/register"
    end
    def create_user
        @user = User.create(user_params.merge(admin: false))
        if @user.valid? 
            session[:user_id] = @user.id
            redirect_to tasks_path
        else
        flash[:error] = "Not a valid username or password"
        render "sessions/register"
        end
    end

    private
        def user_params
            params.require(:user).permit(:name,:email, :password, :password_confirmation)
        end
end
