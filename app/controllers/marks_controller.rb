class MarksController < ApplicationController
  def create
    @stamp = Stamp.find(params[:stamp_id])
    @mark = @stamp.marks.create!(:marked_on => params[:date], :position_x => params[:x], :position_y => params[:y])
    flash[:notice] = "Successfully created mark."
    redirect_to root_url
  end
  
  def destroy
    @mark = Mark.find(params[:id])
    @mark.destroy
    flash[:notice] = "Successfully destroyed mark."
    redirect_to root_url
  end
end
