require 'spec_helper'

feature 'Authentication' do

  scenario 'Edits should be authenticated' do
    visit '/admin/about/edit'
    page.status_code.should == 401
  end

  scenario 'Show should not be authenticated' do
    visit '/about-me'
    page.status_code.should == 200
  end

end

feature 'Create About' do
  include AuthHelper

  before(:each) { About.all.destroy_all }

  scenario 'visit / before About has been created' do
    expect do
      visit root_path
    end.to change(About, :count).by(1)
    page.status_code.should == 200
  end

  scenario 'edit before About has been created' do
    http_login
    expect do
      visit edit_admin_about_path
    end.to change(About, :count).by(1)
    page.status_code.should == 200
  end

end
feature 'Edit About' do

  scenario 'update About' do
    about_text = 'A little about me'
    about = about_on_page(about_text)

    about.edit
    about.view_about

    about.should have_body(about_text)
  end

  def about_on_page(text)
    AboutOnPage.new(text)
  end
end
