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
    page.should have_link 'Edit Technology', href: admin_technologies_path
    page.should have_link 'Edit Project', href: admin_projects_path
    page.should have_link 'Edit Employment', href: admin_employments_path
    page.should have_link 'Edit About Me', href: edit_admin_about_path
  end

  scenario 'admin technologies index' do
    visit admin_technologies_path
    techs = Technology.all
    techs.each do |tech|
      page.should have_link tech.name, href: edit_technology_path(tech)
    end
  end

  scenario 'admin projects index' do
    visit admin_projects_path
    projects = Project.all
    projects.each do |project|
      page.should have_link project.name, href: edit_project_path(project)
    end
  end

  scenario 'admin employments index' do
    visit admin_employments_path
    employments = Employment.all
    employments.each do |employment|
      page.should have_link employment.name, href: edit_employment_path(employment)
    end
  end

end
