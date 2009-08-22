require File.dirname(__FILE__) + '/../spec_helper'
 
describe MarksController do
  fixtures :all
  integrate_views
  
  it "create action should redirect when model is valid" do
    Mark.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(root_url)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    mark = Mark.first
    delete :destroy, :id => mark
    response.should redirect_to(root_url)
    Mark.exists?(mark.id).should be_false
  end
end
