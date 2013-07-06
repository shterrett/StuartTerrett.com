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
  
end

feature "Edit Employment" do
  
  before(:all) { FactoryGirl.create(:employment) }
  
  scenario "Edit Employments Form" do
    visit "/employments/new"
    page.should have_field "Company"
    page.should have_field "Position"
    page.should have_field "employment_description"
    page.should have_field "employment_start_date"
    page.should have_field "employment_end_date"
    page.should have_field "employment_url"
    page.should have_button "Create Employment"
  end
  
  scenario "Update Employment" do
    employment = Employment.all.last
    visit "/employments/#{employment.id}/edit"
    fill_in "employment_description", with: "Lorem Ipsum Edited"
    click_button "Update Employment"
    employment_2 = Employment.find(employment.id)
    employment_2.description.should == "Lorem Ipsum Edited"
  end
  
end

feature "Resume" do
  
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
      page.should have_text empl.description
    end
  end
  
end
    