require 'spec_helper'

feature "Authentication" do

  scenario "New Employment should be authenticated" do
    visit "/employments/new"
    page.status_code.should == 401
  end

  scenario "Edit Employments should be authenticated" do
    employment = FactoryGirl.create(:employment)
    visit "/employments/#{employment.id}/edit"
    page.status_code.should == 401
  end

  scenario "Show Employment should not be authenticated" do
    employment = FactoryGirl.create(:employment)
    visit "/employments/#{employment.id}"
    page.status_code.should == 200
  end

  scenario "Index Employments should not be authenticated" do
    visit "/resume"
    page.status_code.should == 200
  end

end

feature "Create Employment" do

  include AuthHelper

  before(:each) { http_login }

  scenario "New Employments Form" do
    visit "/employments/new"
    page.should have_field "Company"
    page.should have_field "Position"
    page.should have_field "employment_description"
    page.should have_field "employment_start_date"
    page.should have_field "employment_end_date"
    page.should have_field "employment_url"
    page.should have_field "employment_technology_tokens"
    page.should have_field "employment_project_tokens"
    page.should have_button "Create Employment"
  end

  scenario "Create New Employment", js: true do
    visit "/employments/new"
    fill_in "Company", with: "Millennium Partners Sports Club Management"
    fill_in "Position", with: "Web Application Developer"
    fill_in "employment_description", with: "Lorem Ipsum"
    fill_in "employment_start_date", with: "2011-07-05"
    fill_in "employment_end_date", with: "2014-07-05"
    fill_in "employment_url", with: "http://sportsclubla.com"
    click_button "Create Employment"
    page.should have_text 'Employment created successfully'
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
    fill_in 'employment_technology_tokens', with: tech.id
    fill_in 'employment_project_tokens', with: ''
    click_button "Create Employment"
    page.should have_text 'Employment created successfully'
    expect(EmploymentTech.last.technology_id).to eq(tech.id)
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
    fill_in 'employment_project_tokens', with: project.id
    fill_in 'employment_technology_tokens', with: ''
    click_button "Create Employment"
    expect(Employment.last.projects).to eq [project]
  end

end

feature "Edit Employment" do
  include AuthHelper
  before(:each) { http_login }

  scenario "Edit Employments Form" do
    employment = FactoryGirl.create(:employment)
    visit "/employments/#{employment.id}/edit"
    page.should have_field "Company"
    page.should have_field "Position"
    page.should have_field "employment_description"
    page.should have_field "employment_start_date"
    page.should have_field "employment_end_date"
    page.should have_field "employment_url"
    page.should have_button "Update Employment"
  end

  scenario "Update Employment", js: true do
    employment =  FactoryGirl.create(:employment)
    visit "/employments/#{employment.id}/edit"
    fill_in "employment_description", with: "Lorem Ipsum Edited"
    click_button "Update Employment"
    page.should have_text "Lorem Ipsum Edited"
  end

  scenario "Update Employment without changing projects or technologies", js: true do
    employment = FactoryGirl.create(:employment)
    tech = FactoryGirl.create(:technology)
    project = FactoryGirl.create(:project)
    employment.projects << project
    employment.technologies << tech
    visit "/employments/#{employment.id}/edit"
    fill_in "employment_description", with: "Lorem Ipsum Edited"
    click_button "Update Employment"
    employment_2 = Employment.find(employment.id)
    employment_2.technologies.should include(tech)
    employment_2.projects.should include(project)
  end

  scenario "Update Employment Technologies" do
    employment = FactoryGirl.create(:employment)
    tech = FactoryGirl.create(:technology)
    tech_2 = FactoryGirl.create(:technology)
    employment.technologies << tech
    visit "/employments/#{employment.id}/edit"
    fill_in 'employment_technology_tokens', with: tech_2.id
    fill_in 'employment_project_tokens', with: ''
    click_button "Update Employment"
    employment.reload
    employment.technologies.should include(tech_2)
    employment.technologies.should_not include(tech)
  end

  scenario "Update Employment Projects" do 
    employment = FactoryGirl.create(:employment)
    proj = FactoryGirl.create(:project)
    proj_2 = FactoryGirl.create(:project)
    employment.projects << proj
    visit "/employments/#{employment.id}/edit"
    fill_in 'employment_project_tokens', with: proj_2.id
    fill_in 'employment_technology_tokens', with: ''
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
      page.should have_text empl.format_date(:start_date)
      page.html.should include render_markdown(empl.description)
    end
  end

end

feature "View Employment" do
  include ApplicationHelper

  it "should show details of employment" do
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
    visit "/employments/#{employment.id}"
    page.should have_text employment.company
    page.html.should include render_markdown(employment.description)
    page.should have_text employment.url
    page.should have_text employment.position
  end

  it "should list technologies associated with employment" do
    employment = FactoryGirl.create(:employment)
    technology = FactoryGirl.create(:technology)
    employment.technologies << technology
    visit "/employments/#{employment.id}"
    page.should have_text employment.technologies.first.name
  end

  it "should list projects associated with employment" do
    employment = FactoryGirl.create(:employment)
    project = FactoryGirl.create(:project)
    employment.projects << project
    visit "/employments/#{employment.id}" 
    page.should have_text employment.projects.first.name
  end
end
