require 'spec_helper'

feature "Authentication" do

  scenario "New Technology should be authenticated" do
    visit "/technologies/new"
    page.status_code.should == 401
  end

  scenario "Edit Technology should be authenticated" do
    visit "/technologies/#{Technology.all.first.id}/edit"
    page.status_code.should == 401
  end

  scenario "Show Technology should not be authenticated" do
    visit "/technologies/#{Technology.all.first.id}"
    page.status_code.should == 200
  end

  scenario "Index Technologies should not be authenticated" do
    visit "/technologies"
    page.status_code.should == 200
  end

end

feature "New Technology" do
  
  include AuthHelper
  before(:each) { http_login }
  
  scenario "visit /technologies/new" do
    visit '/technologies/new'
    page.should have_field "Name"
    page.should have_field "Abbreviation"
    page.should have_field "technology_description"
    page.should have_button "Create Technology"
  end
  
  scenario "create new technology" do
    visit '/technologies/new'
    fill_in "Name", with: "Ruby"
    fill_in "Abbreviation", with: "ruby"
    expect do
      click_button "Create Technology"
    end.to change(Technology, :count).by(1)
    page.should have_text "Technology created successfully"
  end
  
end    

feature "Edit Technology" do
  before(:all) { FactoryGirl.create(:technology) }
 
  include AuthHelper
  before(:each) { http_login }

  scenario "visit /technologies/:id/edit" do
    tech = Technology.all.first
    id = tech.id
    visit "/technologies/#{id}/edit"
    page.should have_field "Name"
    page.should have_field "Abbreviation"
    page.should have_button "Update Technology"
  end
  
  scenario "edit technology" do
    tech = Technology.all.first
    visit "/technologies/#{tech.id}/edit"
    fill_in "Name", with: "EditedName"
    fill_in "Abbreviation", with: "edits"
    click_button "Update Technology"
    new_tech = Technology.find(tech.id)
    new_tech.name.should == "EditedName"
    new_tech.abbreviation.should == "edits"
    page.should have_text "Technology updated successfully"
  end
  
end

feature "View Technology" do
  before(:all) do 
    tech = FactoryGirl.create(:technology)
    project = FactoryGirl.create(:project)
    project_2 = FactoryGirl.create(:project)
    ProjectTech.create({ technology_id: tech.id, project_id: project.id })
    ProjectTech.create({ technology_id: tech.id, project_id: project_2.id })
  end
  
  scenario "visit show technology page" do
    tech = Technology.all.last
    visit "/technologies/#{tech.id}"
    page.should have_text tech.name
    page.should have_text tech.description
    tech.projects.each do |proj|
      page.should have_link proj.name, href: project_path(proj)
    end
  end
  
  scenario "visit technology index page" do
    techs = Technology.all
    visit "/technologies/"
    techs.each do |tech|
      page.should have_link tech.name, href: technology_path(tech)
    end
  end
  
end
  
