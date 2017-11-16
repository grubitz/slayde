class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  protected

  def authenticate_user!
    redirect_to new_session_url unless current_user.present?
  end

  def authenticate_admin!
    raise 'not authorised' unless current_user.present? && current_user.is_admin?
  end

  def redirect_if_logged_in
    redirect_to root_url, notice: "You're already logged in!" if current_user.present?
  end

end
