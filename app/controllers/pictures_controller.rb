class PicturesController < ApplicationController
  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user = current_user unless current_user.is_admin?
    if @picture.save
      redirect_to root_url, notice: t('picture.uploaded')
    else
      render :new
    end
  end

  private

  def picture_params
    params.require(:picture).permit(:image, :name)
  end

end
