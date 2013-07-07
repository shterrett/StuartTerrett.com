require 'spec_helper'

feature "Create Employment" do
  
  scenario "New Employments Form" do
    visit "/employments/new"
    page.should have_field "Company"
    page.should have_field "Position"
    page.should have_field "employment_description"
    page.should have_field "employment_start_date"
    page.should have_field "employment_end_date"
    page.should have_field "employment_url"
    page.should have_select "employment_technologies"
    page.should have_select "employment_projects"
    page.should have_button "Create Employment"
  end
  
  scenario "Create New Employment" do
    visit "/employments/new"
    fill_in "Company", with: "Millennium Partners Sports Club Management"
    fill_in "Position", with: "Web Application Developer"
    fill_in "employment_description", with: "Lorem Ipsum"
    fill_in "employment_start_date", with: "2011-07-05"
    fill_in "employment_end_date", with: "2014-07-05"
    fill_in "employment_url", with: "http://sportsclubla.com"
    expect do
      click_button "Create Employment"
    end.to change(Employment, :count).by(1)
  end
  
  scenario "Create Employment and associate with technologies" do
    tech = FactoryGirl.create(:technology)
    visit "/employments/new"
    fill_in "Company", with: "Millennium Partners Sports Club Management"
    fill_in "Position", with: "Web Application Developer"
    fill_in "employment_description", with: "Lorem Ipsum"
    fill_in "employment_start_date", with: "2011-07-05"
    fill_in "employment_end_date", with: "2014-07-05"
    fill_in "employment_url", with: "http://sportsclubla.com"
    select tech.name, from: "employment_technologies"
    expect do
      click_button "Create Employment" 
    end.to change(EmploymentTech, :count).by(1)
  end
  
  scenario "Create Employment and associate with projects" do
    project = FactoryGirl.create(:project)
    visit "/employments/new"
    fill_in "Company", with: "Millennium Partners Sports Club Management"
    fill_in "Position", with: "Web Application Developer"
    fill_in "employment_description", with: "Lorem Ipsum"
    fill_in "employment_start_date", with: "2011-07-05"
    fill_in "employment_end_date", with: "2014-07-05"
    fill_in "employment_url", with: "http://sportsclubla.com"
    select project.name, from: "employment_projects"
    click_button "Create Employment"
    project.reload
    project.employment.should_not be_nil
  end
  
end

feature "Edit Employment" do
  
  before(:all) { FactoryGirl.create(:employment) }
  
  scenario "Edit Employments Form" do
    employment = Employment.all.last
    visit "/employments/#{employment.id}/edit"
    page.should have_field "Company"
    page.should have_field "Position"
    page.should have_field "employment_description"
    page.should have_field "employment_start_date"
    page.should have_field "employment_end_date"
    page.should have_field "employment_url"
    page.should have_button "Update Employment"
  end
  
  scenario "Update Employment" do
    employment = Employment.all.last
    visit "/employments/#{employment.id}/edit"
    fill_in "employment_description", with: "Lorem Ipsum Edited"
    click_button "Update Employment"
    employment_2 = Employment.find(employment.id)
    employment_2.description.should == "Lorem Ipsum Edited"
  end
  
  scenario "Update Employment Technologies" do
    employment = Employment.last
    tech = FactoryGirl.create(:technology)
    tech_2 = FactoryGirl.create(:technology)
    employment.technologies << tech
    visit "/employments/#{employment.id}/edit"
    unselect tech.name, from: "employment_technologies"
    select tech_2.name, from: "employment_technologies"
    click_button "Update Employment"
    employment.reload
    employment.technologies.should include(tech_2)
    employment.technologies.should_not include(tech)
  end
  
  scenario "Update Employment Projects" do 
    employment = Employment.last
    proj = FactoryGirl.create(:project)
    proj_2 = FactoryGirl.create(:project)
    employment.projects << proj
    visit "/employments/#{employment.id}/edit"
    unselect proj.name, from: "employment_projects"
    select proj_2.name, from: "employment_projects"
    click_button "Update Employment"
    employment.reload
    employment.projects.should include(proj_2)
    employment.projects.should_not include(proj)
  end
  
end

feature "Resume" do
  include ApplicationHelper
  
  before(:all) do
    10.times { FactoryGirl.create(:employment) }
  end
  after(:all) { Employment.destroy_all }
  
  scenario "Visit Resume page" do
    visit "/resume"
    employment = Employment.all
    employment.each do |empl|
      page.should have_text empl.company
      page.should have_text empl.start_date
      page.html.should include render_markdown(empl.description)
    end
  end
  
end

feature "View Employment" do
  include ApplicationHelper
  
  before(:all) do
    employment = Employment.create({
      company: "Millennium Partners Sports Club Management",
      position: "Web Application Developer",
      start_date: "2012-10-01",
      end_date: "2014-09-30",
      url: "http://sportsclubla.com",
      description: """#Backend Web Applications
      + Custom Sitefinity Modules for company website and all clubs
      + Web App for Private Trainers to track sessions with clients
      + gem and backend for Group Ex Scheduling that consumes APIs from CSI SpectrumNG"""
    })
    technology = Technology.create({
      name: "Ruby on Rails",
      description: "Working in Rails for almost 2 years...blah blah blah",
      abbreviation: "rails"
    })
    employment.technologies << technology
    project = Project.create({
      name: "Fitness Schedules",
      description: """Application that allows private trainers to track workouts with clients:
      + Input exercises for each workout
      + track date of workout
      + track completion of workout
      + Client sign-off on each workout
      + permanent record and reports for all workouts",
      short_description: "Application that allows private trainers to track workouts with clients""",
      source: "Closed"
    })
    employment.projects << project
  end
  
  let(:employment) { Employment.where({
      company: "Millennium Partners Sports Club Management",
      position: "Web Application Developer"}).last }
  
  it "should show details of employment" do
    visit "/employments/#{employment.id}"
    page.should have_text employment.company
    page.html.should include render_markdown(employment.description)
    page.should have_text employment.url
    page.should have_text employment.position
  end
  
  it "should list technologies associated with employment" do
    visit "/employments/#{employment.id}"
    page.should have_text employment.technologies.first.name
  end
  
  it "should list projects associated with employment" do
    visit "/employments/#{employment.id}" 
    page.should have_text employment.projects.first.name
  end
  
end
    