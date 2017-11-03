class EmailConfirmationsController < ApplicationController
  def confirm
    user = User.find_by(confirmation_token: params[:token])
    if user.present?
      user.confirm!
      redirect_to root_url
    else
      raise('Incorrect Token')
    end

  end
end
