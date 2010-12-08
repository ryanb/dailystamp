Dailystamp::Application.routes.draw do
  root :to => 'stamps#index'
  
  match 'signup' => 'users#new', :as => 'signup'
  match 'logout' => 'user_sessions#destroy', :as => 'logout'
  match 'login' => 'user_sessions#new', :as => 'login'
  match 'home' => 'stamps#index', :as => 'home', :no_redirect => 'true'
  
  resources :user_sessions
  resources :users
  resources :favorites
  resources :stamp_images
  resources :marks
  resources :stamps do
    member do
      get :edit_goal
    end
  end
end
