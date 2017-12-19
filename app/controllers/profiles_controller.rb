class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @profile = current_user
  end

  def update
    @profile = current_user
    if @profile.update_with_password(profile_params)
      redirect_to(edit_profile_url, notice: 'Changes saved')
    else
      render :edit
    end
  end

  protected

  def profile_params
    params.require(:user).permit(:email, :current_password, :password, :password_confirmation)
  end

end
