# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
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
