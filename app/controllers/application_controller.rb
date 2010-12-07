class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery
  
  before_filter :set_user_time_zone
  
  private
  
  def current_user_or_guest
    unless logged_in?
      @current_user = User.create!(:guest => true)
    end
    current_user
  end
  
  def set_user_time_zone
    Time.zone = current_user.time_zone if logged_in? && !current_user.time_zone.blank?
  end
end
