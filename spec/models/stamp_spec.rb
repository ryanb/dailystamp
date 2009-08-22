require File.dirname(__FILE__) + '/../spec_helper'

describe Stamp do
  it "should be valid" do
    Stamp.new.should be_valid
  end
end
