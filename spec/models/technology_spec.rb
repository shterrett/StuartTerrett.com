require 'spec_helper'

describe Technology do
  
  let(:tech) { FactoryGirl.build(:technology) }
  
  describe "validations" do
    
    it "should be valid when all specified" do
      tech.should be_valid
    end
    
    it "should validate presence of name" do
      tech.name = nil
      tech.should_not be_valid
    end
    
    it "should validate presence of abbreviation" do
      tech.abbreviation = nil
      tech.should_not be_valid
    end
    
  end
  
  describe "relationships" do
    
    it "should have_many projects" do
      project = FactoryGirl.create(:project)
      tech.projects << project
      tech.projects.first.should == project
    end
    
  end
    
end
