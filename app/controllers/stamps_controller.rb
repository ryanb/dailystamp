class StampsController < ApplicationController
  before_filter :login_required, :only => [:edit, :update, :destroy]
  
  def index
    @stamp = Stamp.new
  end
  
  def show
    @stamp = Stamp.find(params[:id])
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end
  
  def new
    @stamp = Stamp.new
    render :action => "index"
  end
  
  def create
    @stamp = Stamp.new(params[:stamp])
    @stamp.stamp_image ||= StampImage.first
    @stamp.user = current_user
    if @stamp.save
      redirect_to @stamp
    else
      render :action => "index"
    end
  end
  
  def edit
    @stamp = current_user.stamps.find(params[:id])
  end
  
  def update
    @stamp = current_user.stamps.find(params[:id])
    if @stamp.update_attributes(params[:stamp])
      redirect_to @stamp
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @stamp = current_user.stamps.find(params[:id])
    @stamp.destroy
    redirect_to stamps_url
  end
end
