require File.dirname(__FILE__) + '/../spec_helper'
 
describe MarksController do
  fixtures :all
  integrate_views
  
  it "create action should create mark with given stamp id and date" do
    post :create, :stamp_id => Stamp.first.id, :date => "2009-02-01"
    response.should redirect_to(root_url)
    Mark.last.marked_on.should == Date.parse("2009-02-01")
    Mark.last.stamp_id.should == Stamp.first.id
  end
  
  it "destroy action should destroy model and redirect to index action" do
    mark = Mark.first
    delete :destroy, :id => mark
    response.should redirect_to(root_url)
    Mark.exists?(mark.id).should be_false
  end
end
