class StampsController < ApplicationController
  def index
    @stamps = Stamp.all
  end
  
  def show
    @stamp = Stamp.find(params[:id])
  end
  
  def new
    @stamp = Stamp.new
  end
  
  def create
    @stamp = Stamp.new(params[:stamp])
    if @stamp.save
      flash[:notice] = "Successfully created stamp."
      redirect_to @stamp
    else
      render :action => 'new'
    end
  end
  
  def edit
    @stamp = Stamp.find(params[:id])
  end
  
  def update
    @stamp = Stamp.find(params[:id])
    if @stamp.update_attributes(params[:stamp])
      flash[:notice] = "Successfully updated stamp."
      redirect_to @stamp
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @stamp = Stamp.find(params[:id])
    @stamp.destroy
    flash[:notice] = "Successfully destroyed stamp."
    redirect_to stamps_url
  end
end
