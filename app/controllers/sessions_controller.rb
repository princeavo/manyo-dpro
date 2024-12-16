class SessionsController < ApplicationController
    include SessionHelper
    # before_action :authenticate_user , only: %i[destroy,profile,update_profile]
    # before_action :unauthenticate_user , except: %i[destroy,profile,update_profile]

    before_action :authenticate_or_unauthenticate_user

    def register
        @user = User.new
        render "sessions/register"
    end
    def create_user
        @user = User.create(user_params.merge(admin: false))
        if @user.valid? 
            session[:user_id] = @user.id
            flash[:success] = t("new_account_page.success_message")
            redirect_to tasks_path
        else
            flash[:error] = "Not a valid username or password"
            render "sessions/register"
        end
    end
    def login
        @user = User.new
        render "sessions/login"
    end
    def authenticate
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success] = t("login_page.success_message")
            redirect_to tasks_path
        else
            flash[:error] = t("login_page.bad_credentials_error_message")
            render "sessions/login"
        end
    end
    def destroy
        session.clear
        redirect_to tasks_path
    end
    def logout
        session.clear
        flash[:success] = t("login_page.logout_success_message")
        redirect_to login_path
    end
    def profile
        @user = current_user
        render "sessions/profile"
    end
    def update_profile
        @user = User.find(current_user.id)
        if @user.update(user_params)
            redirect_to show_profile_path ,:notice => t("account_settings_page.success_message")
        else
            render "sessions/profile"
        end
    end
    private
        def user_params
            params.require(:user).permit(:name,:email, :password, :password_confirmation)
        end
        def user_params_login
            params.require(:user).permit(:email, :password)
        end
        def authenticate_or_unauthenticate_user
            if ["logout","profile","update_profile","show_profile"].include? action_name
              authenticate_user
            else
              unauthenticate_user
            end
        end
end
