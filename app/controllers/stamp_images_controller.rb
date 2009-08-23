class StampImagesController < ApplicationController
  before_filter :login_required
  
  def new
    @stamp_image = StampImage.new
  end
  
  def create
    @stamp_image = StampImage.new(params[:stamp_image])
    @stamp_image.user = current_user
    if @stamp_image.save
      @stamp_image.generate_graphics
      respond_to do |format|
        format.html { redirect_to((current_user && edit_stamp_path(current_user.current_stamp)) || root_url) }
        format.js
      end
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @stamp_image = current_user.stamp_images.find(params[:id])
    @stamp_image.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
end
