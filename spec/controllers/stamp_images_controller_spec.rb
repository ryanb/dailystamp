require File.dirname(__FILE__) + '/../spec_helper'
 
describe StampImagesController do
  fixtures :all
  integrate_views
  
  it "create action should render new template when model is invalid" do
    StampImage.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    StampImage.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(root_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    stamp_image = StampImage.first
    delete :destroy, :id => stamp_image
    response.should redirect_to(root_url)
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
