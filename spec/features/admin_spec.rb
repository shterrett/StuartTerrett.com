require 'spec_helper'

feature "List Admin tasks" do

  scenario "Visit admin landing page" do
    visit "/admin"
    page.should have_link "Add Technology", href: new_technology_path 
    page.should have_link "Add Employment", href: new_employment_path
    page.should have_link "Add Project", href: new_project_path
    page.should have_link "Edit Technology", href: admin_technologies_path
    page.should have_link "Edit Project", href: admin_projects_path
    page.should have_link "Edit Employment", href: admin_employments_path
    page.should have_link "Edit About Me", href: about_edit_path
  end

  scenario "Visit edit technology page" do
    visit "/admin/technologies"
    techs = Technology.all
    techs.each do |tech|
      page.should have_link tech.name, href: edit_tech_path(tech)
    end
  end

  scenario "Visit edit project page" do
    visit "/admin/projects"
    projects = Project.all
    projects.each do |project|
      page.should have_link project.name, href: edit_project_path(project)
    end
  end

  scenario "Visit edit employment page" do
    visit "/admin/employments"
    employments = Employment.all
    employments.each do |employment|
      page.should have_link employment.name, href: edit_employment_path(employment)
    end
  end

end
