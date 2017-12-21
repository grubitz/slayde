class EmailConfirmationsController < ApplicationController
  def confirm
    @user = User.find_by(confirmation_token: params[:token])
    if @user.present?
      @user.confirm!
      redirect_to root_url, notice: t('confirmation_confirmation', email: @user.email)
    else
      raise UserError.new(t('incorrect_token'))
    end

  end
end
