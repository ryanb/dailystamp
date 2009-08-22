class MarksController < ApplicationController
  def create
    @stamp = Stamp.find(params[:stamp_id])
    @mark = @stamp.marks.create!(:marked_on => params[:date], :position_x => params[:x], :position_y => params[:y], :skip => (params[:skip] == "true"))
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
  
  def destroy
    @mark = Mark.find(params[:id])
    @mark.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
end
