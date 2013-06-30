require 'spec_helper'

feature "New Technology" do
  
  scenario "visit /technologies/new" do
    visit '/technologies/new'
    page.should have_field "Name"
    page.should have_field "Abbreviation"
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