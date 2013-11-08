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
      project.save
      project.reload
      project.technologies.first.should == technology
    end
    
    it "should belong_to employment" do
      employment = FactoryGirl.create(:employment)
      employment.projects << project
      project.reload 
      project.employment.should == employment
    end

    it "returns an array of associated technology ids" do
      technology = FactoryGirl.create(:technology)
      project.technologies << technology
      project.technology_tokens.should == [technology.id]
      project.technology_ids.should == project.technology_tokens
    end

    it "parses a string of technolgy ids" do
      3.times { FactoryGirl.create(:technology) }
      technology_ids = Technology.all.pluck(:id)
      project.technology_tokens = technology_ids.join(",")
      project.technology_ids.should == technology_ids
    end
  end
  
  describe "source code links" do
    
    it "should return a link to the source if open/exists" do
      project = FactoryGirl.create(:project)
      project.source_link.should == "<a href='#{project.source}'>View Source</a>".html_safe
    end
    
    it "should return 'Closed Source' if source is 'Closed' or doesn't exist'" do
      project = FactoryGirl.create(:closed_project)
      project.source_link.should == "Closed Source"
    end
    
  end
  
end
