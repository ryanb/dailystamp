require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  it "should not have validations for guest user" do
    User.new(:guest => true).should be_valid
  end
  
  it "should not have username/email validations for openid user" do
    User.new(:openid_identifier => "http://myopenid.com").should be_valid
  end
  
  it "should validate email format for openid identifier" do
    User.new(:openid_identifier => "http://myopenid.com", :email => "bad email").should have(1).error_on(:email)
  end
  
  it "should validate username format for openid identifier" do
    User.new(:openid_identifier => "http://myopenid.com", :username => "x").should have(1).error_on(:username)
  end
  
  it "should require username when password is given" do
    User.new(:password => "secret", :password_confirmation => "secret").should have(1).error_on(:username)
  end
  
  it "should require username when password is given" do
    User.new(:password => "secret", :password_confirmation => "secret").should_not be_valid
  end
  
  it "should require username when password when nothing given" do
    user = User.new
    user.should_not be_valid
    user.errors[:username].to_s.should =~ /too short/
    user.errors[:password].to_s.should =~ /too short/
  end
end
