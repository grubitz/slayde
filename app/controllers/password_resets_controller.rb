class PasswordResetsController < ApplicationController
  before_action :find_user_by_token, only: [:edit, :update]

  def new; end

  def create
    user = User.find_by(email: params[:email])
    user.send_reset_password! if user.present?
    redirect_to root_url, notice: t('sent_email', email: params[:email])
  end

  def edit; end

  def update
    if @user.update(password: user_params[:password],
                    password_confirmation: user_params[:password_confirmation])
      session[:user_id] = @user.id
      redirect_to root_url, notice: t('password_change_confirm')
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def find_user_by_token
    @user = User.find_by(reset_password_token: params[:token])
    raise UserError.new(t('incorrect_token')) unless @user.present?
  end

end
