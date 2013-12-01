require 'spec_helper'

feature 'Authentication' do

  scenario 'Admin Index should be authenticated' do
    visit '/admin'
    page.status_code.should == 401
  end

end

feature 'List Admin tasks' do
  include AuthHelper

  before(:each) { http_login }

  scenario 'Visit admin landing page' do
    visit '/admin'
    page.should have_link 'Add Technology', href: new_admin_technology_path
    page.should have_link 'Add Employment', href: new_admin_employment_path
    page.should have_link 'Add Project', href: new_admin_project_path
    page.should have_link 'Add Post', href: new_admin_post_path
    page.should have_link 'Edit Technology', href: admin_technologies_path
    page.should have_link 'Edit Project', href: admin_projects_path
    page.should have_link 'Edit Employment', href: admin_employments_path
    page.should have_link 'Edit About Me', href: edit_admin_about_path
    page.should have_link 'Edit Post', href: admin_posts_path
  end

  scenario 'admin technologies index' do
    technology = FactoryGirl.create(:technology)
    visit admin_technologies_path
    page.should have_link technology.name, href: edit_admin_technology_path(technology)
  end

  scenario 'admin projects index' do
    project = FactoryGirl.create(:project)
    visit admin_projects_path
    page.should have_link project.name, href: edit_admin_project_path(project)
  end

  scenario 'admin employments index' do
    employment = FactoryGirl.create(:employment)
    visit admin_employments_path
    page.should have_link employment.name, href: edit_admin_employment_path(employment)
  end

  scenario 'admin posts index' do
    post = FactoryGirl.create(:post)
    visit admin_posts_path
    page.should have_link post.title, href: edit_admin_post_path(post)
  end
end
