require 'spec_helper'

feature "Edit About" do
  
  scenario "visit /about/edit" do
    visit "/about/edit"
    page.should have_field "about_info"
    page.should have_button "Update About"
  end
  
  scenario "update About" do
    visit '/about/edit'
    text = "This is a little bit about me"
    fill_in "about_info", with: text
    click_button "Update About"
    About.find(1).info.should == text
    page.should have_text text
  end

end


    