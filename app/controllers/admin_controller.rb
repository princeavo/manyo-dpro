class AdminController < ApplicationController
  include SessionHelper
  before_action :autorize_admin_only
  def list
    @users = User.left_joins(:tasks)
                .select("users.*, COUNT(tasks.id) AS tasks_count")
                .group("users.id")
    render "admin/list"
  end
  def new
    @user = User.new
    render "admin/new_user"
  end
  def create
    @user = User.create(user_params)
    if @user.valid? 
      flash[:success] = t("new_account_page.success_message")
      redirect_to admin_users_path
    else
      render "admin/new_user"
    end
  end
  def show
    @user = User.find(params[:id])
    render "admin/details_user"
  end
  def edit
    @user = User.find(params[:id])
    render "admin/edit_user"
  end
  def update_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = t("admin_pages.edit_user.success_message")
      redirect_to admin_users_path
    else
      render "admin/edit_user"
    end
  end
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = t("admin_pages.delete_uer.success_message")
      redirect_to admin_users_path
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      redirect_to admin_users_path
    end
  end
  private
    def user_params
      params.require(:user).permit(:name, :email,:password, :password_confirmation, :admin)
    end
end
