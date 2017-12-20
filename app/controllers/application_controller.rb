class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  rescue_from UserError, with: :handle_user_error

  protected

  def handle_user_error(error)
    redirect_to root_url, alert: error.message
  end

  def authenticate_user!
    redirect_to new_session_url unless current_user.present?
  end

  def authenticate_admin!
    raise UserError.new('not authorised') unless current_user.present? && current_user.is_admin?
  end

  def redirect_if_logged_in
    redirect_to root_url, notice: "You're already logged in!" if current_user.present?
  end

end
