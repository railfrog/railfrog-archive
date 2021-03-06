require File.dirname(__FILE__) + '/../../spec_helper'

module FucdRbac
  context "A membership (in general)" do
    include SpecHelpers
    
    setup do
      @membership = Membership.new
    end
    
    specify "should be invalid without a user" do
      @membership.attributes = required_membership_attributes.except(:user_id)
      @membership.should_have(1).error_on(:user_id)
    end
    
    specify "should be invalid without a role" do
      @membership.attributes = required_membership_attributes.except(:role_id)
      @membership.should_have(1).error_on(:role_id)
    end
  end
  
  context "A membership with a user and a role" do
    include SpecHelpers
    
    setup do
      @membership = Membership.new required_membership_attributes
    end
    
    specify "should be valid" do
      @membership.should_be_valid
    end
  end
end
