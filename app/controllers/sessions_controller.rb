class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]
  before_action :authenticate_user!, only: [:destroy]

  def new; end

  def create
    user = User.find_by(email: session_params[:email])
    raise UserError.new(t('bad_email')) if user.nil?
    user.authenticate!(session_params[:password])
    session[:user_id] = user.id
    redirect_to root_url, notice: t('session.open')
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: t('session.destroy')
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
