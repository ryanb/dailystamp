class MarksController < ApplicationController
  def create
    @mark = Mark.create!(params[:mark])
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
