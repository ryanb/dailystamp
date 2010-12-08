require File.dirname(__FILE__) + '/../spec_helper'
 
describe StampsController, "as guest" do
  fixtures :all
  render_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Stamp.first
    response.should render_template(:show)
  end
  
  it "new action should redirect to login" do
    get :new
    response.should redirect_to(login_path)
  end
  
  it "create action should render new template when model is invalid" do
    Stamp.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:index)
  end
  
  it "create action should redirect when model is valid and create guest user" do
    Stamp.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(stamp_url(assigns[:stamp]))
    assigns[:stamp].user.should_not be_nil
  end
  
  it "edit action should redirect to login" do
    get :edit, :id => Stamp.first
    response.should redirect_to(login_path)
  end
  
  it "edit_goal action should redirect to login" do
    get :edit_goal, :id => Stamp.first
    response.should redirect_to(login_path)
  end
  
  it "update action should redirect to login" do
    Stamp.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Stamp.first
    response.should redirect_to(login_path)
  end
  
  it "destroy action should redirect to login" do
    delete :destroy, :id => Stamp.first
    response.should redirect_to(login_path)
  end
end


describe StampsController, "as stamp owner" do
  fixtures :all
  render_views
  
  before(:each) do
    activate_authlogic
    @current_user = Stamp.first.user
    UserSession.create(Stamp.first.user)
  end
  
  it "index action should redirect to current stamp" do
    @current_user.current_stamp_id = Stamp.first.id
    @current_user.save
    get :index
    response.should redirect_to(stamp_url(Stamp.first))
  end
  
  it "index action should render index when no redirect is specified" do
    @current_user.current_stamp_id = Stamp.first.id
    @current_user.save
    get :index, :no_redirect => "true"
    response.should render_template(:index)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:index)
  end
  
  it "show action should render template even if private" do
    Stamp.first.update_attribute(:private, true)
    get :show, :id => Stamp.first
    response.should render_template(:show)
    Stamp.first.user.reload.current_stamp.should == Stamp.first
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Stamp.first
    response.should render_template(:edit)
  end
  
  it "edit_goal action should render edit_goal template" do
    get :edit_goal, :id => Stamp.first
    response.should render_template(:edit_goal)
  end
  
  it "update action should render edit template when model is invalid" do
    Stamp.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Stamp.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Stamp.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Stamp.first
    response.should redirect_to(stamp_url(assigns[:stamp]))
  end
  
  it "destroy action should destroy model and redirect to next one in list" do
    @current_user.stamps.delete_all
    first_stamp = Factory(:stamp, :user => @current_user)
    second_stamp = Factory(:stamp, :user => @current_user)
    delete :destroy, :id => first_stamp
    response.should redirect_to(stamp_url(second_stamp))
  end
  
  it "destroy action should destroy model and redirect to index when no other stamps" do
    @current_user.stamps.delete_all
    first_stamp = Factory(:stamp, :user => @current_user)
    delete :destroy, :id => first_stamp
    response.should redirect_to(root_url)
  end
end


describe StampsController, "as another user" do
  fixtures :all
  render_views
  
  before(:each) do
    activate_authlogic
    UserSession.create(User.last)
  end
  
  it "show action should redirect to login if private" do
    Stamp.first.update_attribute(:private, true)
    get :show, :id => Stamp.first
    response.should redirect_to(login_path)
  end
  
  it "show action should be able to see public stamp" do
    Stamp.first.update_attribute(:private, false)
    get :show, :id => Stamp.first
    response.should render_template(:show)
    User.last.reload.current_stamp.should_not == Stamp.first
  end
end
