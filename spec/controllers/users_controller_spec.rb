require File.dirname(__FILE__) + '/../spec_helper'
 
describe UsersController, "as a guest" do
  fixtures :all
  render_views
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    User.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(root_url)
  end
  
  it "edit action should redirect to login" do
    get :edit, :id => "current"
    response.should redirect_to(login_url)
  end
  
  it "update action should redirect to login" do
    put :update, :id => "current"
    response.should redirect_to(login_url)
  end
end

describe UsersController, "as a user" do
  fixtures :all
  render_views
  
  before(:each) do
    activate_authlogic
    UserSession.create(User.first)
  end
  
  it "edit action should render edit template" do
    get :edit, :id => "current"
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => "current"
    response.should render_template(:edit)
  end
  
  it "create action should redirect when model is valid" do
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => "current"
    response.should render_template(:edit)
  end
end