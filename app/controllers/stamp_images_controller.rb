class StampImagesController < ApplicationController
  def create
    @stamp_image = StampImage.new(params[:stamp_image])
    @stamp_image.user = current_user
    if @stamp_image.save
      flash[:notice] = "Successfully created stamp image."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @stamp_image = StampImage.find(params[:id])
    @stamp_image.destroy
    flash[:notice] = "Successfully destroyed stamp image."
    redirect_to root_url
  end
  
  def new
    @stamp_image = StampImage.new
  end
end
