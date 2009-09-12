class FavoritesController < ApplicationController
  before_filter :login_required
  
  def index
    @favorites = current_user.favorites
  end
  
  def create
    @favorite = current_user.favorites.build(:stamp_id => params[:stamp_id])
    if @favorite.save
      flash[:notice] = "Started watching stamp."
    else
      flash[:error] = "Unable to watch this stamp."
    end
    redirect_to favorites_url
  end
  
  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
    redirect_to favorites_url
  end
end
