require File.dirname(__FILE__) + '/../spec_helper'

describe MarksController, "as guest" do
  fixtures :all
  render_views
  
  it "create action should redirect to login" do
    post :create
    response.should redirect_to(login_path)
  end
  
  it "destroy action should redirect to login" do
    delete :destroy, :id => Mark.first
    response.should redirect_to(login_path)
  end
end
 
describe MarksController, "as stamp owner" do
  fixtures :all
  render_views
  
  before(:each) do
    activate_authlogic
    UserSession.create(Stamp.first.user)
  end
  
  it "create action should create mark with given stamp id and date" do
    post :create, :stamp_id => Stamp.first.id, :date => "2009-02-01", :x => 123, :y => 456
    response.should redirect_to(root_url)
    mark = Mark.last
    mark.marked_on.should == Date.parse("2009-02-01")
    mark.stamp_id.should == Stamp.first.id
    mark.position_x.should == 123
    mark.position_y.should == 456
  end
  
  it "create action should create mark with skip" do
    post :create, :stamp_id => Stamp.first.id, :date => "2009-02-01", :skip => "true"
    response.should redirect_to(root_url)
    mark = Mark.last
    mark.skip.should be_true
  end
  
  it "create action should render template when js action" do
    post :create, :format => "js", :stamp_id => Stamp.first.id, :date => "2009-02-01"
    response.should render_template("create")
  end
  
  it "destroy action should destroy model and redirect to index action" do
    mark = Mark.first
    delete :destroy, :id => mark
    response.should redirect_to(root_url)
    Mark.exists?(mark.id).should be_false
  end
  
  it "destroy action should render template when js action" do
    mark = Mark.first
    delete :destroy, :id => mark, :format => "js"
    response.should render_template("destroy")
  end
end
