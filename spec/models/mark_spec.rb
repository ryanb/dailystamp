require File.dirname(__FILE__) + '/../spec_helper'

describe Mark do
  it "should be valid" do
    Mark.new.should be_valid
  end
end
