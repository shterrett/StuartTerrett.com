require 'spec_helper'

describe Project do
  
  let(:project) { FactoryGirl.build(:project) }
  
  describe "validations" do
    
    it "should be valid when fully specified" do
      project.should be_valid
    end
    
    it "should validate presence of name" do
      project.name = nil
      project.should_not be_valid
    end
    
    it "should validate the presence of description" do
      project.description = nil
      project.should_not be_valid
    end
    
    it "should validate the presence of short_description" do
      project.short_description = nil
      project.should_not be_valid
    end
  
  end
  
  describe "relationships" do
    
    it "should have_many technologies" do
      technology = FactoryGirl.create(:technology)
      project.technologies << technology
      project.technologies.first.should == technology
    end
    
  end
  
end
