module SessionHelper
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def user_not_logged?
    !current_user.present?
  end
  def user_is_logged?
    current_user.present?
  end
  def current_user_is_admin?
    user_is_logged? && current_user.admin
  end
  def authenticate_user
    redirect_to login_path , :flash => { :error => "Veuillez vous connecter" } if user_not_logged?
  end
  def unauthenticate_user
    redirect_to tasks_path , :flash => { :error => "Veuillez vous déconnecter" } if user_is_logged?
  end
  def autorize_admin_only
    redirect_to tasks_path , :flash => { :error => "Only administrators can access" } if !current_user_is_admin?
  end
end