class StampsController < ApplicationController
  before_filter :login_required, :only => [:new, :edit, :update, :destroy]
  
  def index
    if current_user && current_user.current_stamp
      redirect_to current_user.current_stamp
    else
      @stamp = Stamp.new
    end
  end
  
  def show
    @stamp = Stamp.find(params[:id])
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    if current_user && @stamp.user_id == current_user.id
      current_user.current_stamp_id = @stamp.id
      current_user.save!
    elsif @stamp.private?
      flash[:error] = "You are not authorized to access that stamp."
      redirect_to login_url
    end
  end
  
  def new
    @stamp = Stamp.new
    @stamp.color = current_user.unused_color
    render :action => "index"
  end
  
  def create
    @stamp = Stamp.new(params[:stamp])
    @stamp.stamp_image ||= StampImage.first
    @stamp.user = current_user_or_guest
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
    redirect_to(current_user.stamps.first || root_url)
  end
end
