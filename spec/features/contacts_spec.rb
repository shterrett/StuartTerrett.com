require 'spec_helper'

feature "Create new contact form" do
  
  scenario "Visit new contact form" do
    visit "/contact-me"
    page.should have_field "Name"
    page.should have_field "contact_email"
    page.should have_field "Subject"
    page.should have_field "Body"
    page.should have_button "Send Message"
  end

  scenario "Invalid form" do
    visit "/contact-me"
    click_button "Send Message"
    page.should have_text "not valid"
    current_path.should == "/contacts"
  end  

  scenario "Valid form" do
    visit "/contact-me"
    fill_in "Name", with: "Stuart"
    fill_in "contact_email", with: "stuart@example.com"
    fill_in "Subject", with: "Test"
    fill_in "Body", with: "TEST"
    click_button "Send Message"
    page.should have_text "Thank you"
    current_path.should == root_path
  end
  
end
