require 'spec_helper'

feature "New Technology" do
  
  scenario "visit /technologies/new" do
    visit '/technologies/new'
    page.should have_field "Name"
    page.should have_field "Abbreviation"
    page.should have_button "Create Technology"
  end
  
end    