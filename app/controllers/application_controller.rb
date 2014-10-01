class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def admin_signed_in?
    signed_in? && current_user.admin?
  end

  def member_signed_in?
    signed_in? && current_user.member?
  end

  def require_admin_user
    redirect_to new_user_session_path unless admin_signed_in?
  end

  def require_member_user
    redirect_to new_user_session_path unless member_signed_in?
  end

  def after_sign_in_path_for(user)
    posts_path
  end
end
