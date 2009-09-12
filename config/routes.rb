ActionController::Routing::Routes.draw do |map|
  map.resources :favorites

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.home 'home', :controller => 'stamps', :action => 'index', :no_redirect => "true"
  
  map.resources :user_sessions
  map.resources :users
  map.resources :stamp_images
  map.resources :marks
  map.resources :stamps, :member => { :edit_goal => :get }
  
  map.root :stamps
end
