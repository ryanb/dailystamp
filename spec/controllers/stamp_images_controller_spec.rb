require File.dirname(__FILE__) + '/../spec_helper'

describe StampImagesController, "as guest" do
  it "create action should redirect to login" do
    post :create
    response.should redirect_to(login_path)
  end
  
  it "destroy action should redirect to login" do
    delete :destroy, :id => StampImage.first, :format => "js"
    response.should redirect_to(login_path)
  end
  
  it "new action should redirect to login" do
    get :new
    response.should redirect_to(login_path)
  end
end
 
describe StampImagesController, "as user" do
  fixtures :all
  render_views
  
  before(:each) do
    activate_authlogic
    @current_user = User.first
    UserSession.create(@current_user)
  end
  
  it "create action should render new template when model is invalid" do
    StampImage.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect to current stamp edit form" do
    @current_user.current_stamp = Stamp.first
    @current_user.save!
    StampImage.any_instance.stubs(:valid?).returns(true)
    StampImage.any_instance.expects(:generate_graphics)
    post :create
    response.should redirect_to(edit_stamp_path(Stamp.first))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    stamp_image = StampImage.first
    delete :destroy, :id => stamp_image.id
    response.should redirect_to(root_url)
    StampImage.exists?(stamp_image.id).should be_false
  end
  
  it "destroy action should destroy model and render js template" do
    stamp_image = StampImage.first
    delete :destroy, :id => stamp_image.id, :format => "js"
    response.should render_template(:destroy)
    StampImage.exists?(stamp_image.id).should be_false
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "new action should render new template with js format" do
    get :new, :format => "js"
    response.should render_template(:new)
  end
end
