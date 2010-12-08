require File.dirname(__FILE__) + '/../spec_helper'

describe FavoritesController, "as guest" do
  fixtures :all
  render_views
  
  it "index action should redirect to login" do
    get :index
    response.should redirect_to(login_path)
  end
  
  it "create action should redirect to login" do
    post :create
    response.should redirect_to(login_path)
  end
  
  it "destroy action should redirect to login" do
    delete :destroy, :id => Favorite.first
    response.should redirect_to(login_path)
  end
end
 
describe FavoritesController, "as owner" do
  fixtures :all
  render_views
  
  before(:each) do
    activate_authlogic
    UserSession.create(Favorite.first.user)
  end
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "create action should redirect to index" do
    post :create, :stamp_id => Stamp.first
    response.should redirect_to(favorites_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    favorite = Favorite.first
    delete :destroy, :id => favorite
    response.should redirect_to(favorites_url)
    Favorite.exists?(favorite.id).should be_false
  end
end

