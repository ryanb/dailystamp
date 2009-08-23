class MarksController < ApplicationController
  before_filter :login_required
  
  def create
    @stamp = current_user.stamps.find(params[:stamp_id])
    @mark = @stamp.marks.create!(:marked_on => params[:date], :position_x => params[:x], :position_y => params[:y], :skip => (params[:skip] == "true"))
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
  
  def destroy
    @mark = current_user.marks.find(params[:id])
    @mark.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end
end
