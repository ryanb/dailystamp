class MarksController < ApplicationController
  def create
    @stamp = Stamp.find(params[:stamp_id])
    @mark = @stamp.marks.create!(:marked_on => params[:date], :position_x => params[:x], :position_y => params[:y])
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
  
  def destroy
    @mark = Mark.find(params[:id])
    @mark.destroy
    redirect_to root_url
  end
end
