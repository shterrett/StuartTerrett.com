require 'spec_helper'

feature "Create new contact form" do
  
  scenario "Visit new contact form" do
    visit "/contact-me"
    page.should have_field "Name"
    page.should have_field "contact_email"
    page.should have_field "Subject"
    page.should have_field "Body"
  end
    
  
end