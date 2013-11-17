require 'spec_helper'

feature "Authentication" do

  scenario "Projects New should be authenticated" do
    visit "/projects/new"
    page.status_code.should == 401
  end

  scenario "Projects Edit should be authenticated" do
    project = FactoryGirl.create(:project)
    visit "/projects/#{project.id}/edit"
    page.status_code.should == 401
  end

  scenario "Projects Show should not be authenticated" do
    project = FactoryGirl.create(:project)
    visit "/projects/#{project.id}"
    page.status_code.should == 200
  end

  scenario "Projects Index should not be authenticated" do
    visit "/projects"
    page.status_code.should == 200
  end


end

feature 'Admin' do
  scenario 'Create a project' do
    technology = FactoryGirl.create(:technology)
    project = project_on_page
    project.create do
      name 'New Project'
      description "And blowing into maximum warp speed, you appeared for an instant to be in two places at once. Sorry, Data. We have a saboteur aboard. Earl Grey tea, watercress sandwiches... and Bularian canapés? Are you up for promotion? Sure. You'd be surprised how far a hug goes with Geordi, or Worf. Now, how the hell do we defeat an enemy that knows us better than we know ourselves? Shields up! Rrrrred alert! Mr. Worf, you do remember how to fire phasers? We know you're dealing in stolen ore. But I wanna talk about the assassination attempt on Lieutenant Worf. Fate protects fools, little children and ships named Enterprise. My oath is between Captain Kargan and myself. Your only concern is with how you obey my orders. Or do you prefer the rank of prisoner to that of lieutenant? Wait a minute - you've been declared dead. You can't give orders around here. Damage report! The Federation's gone; the Borg is everywhere! I'm afraid I still don't understand, sir."
      short_description "We know you're dealing in stolen ore. But I wanna talk about the assassination attempt on Lieutenant Worf. Fate protects fools, little children and ships named Enterprise."
      technologies [technology]
    end
    project.view_project
    project.should have_name 'New Project'
    project.should have_technologies [technology]
  end

  scenario 'Technology should be loaded' do
    technology = FactoryGirl.create(:technology)
    project = project_on_page(technology.projects.first)
    project.should have_associated_technologies_on_edit
  end

  scenario 'Edit a project', js: true do
    exemplar = FactoryGirl.create(:project)
    project = project_on_page(exemplar)
    project.edit do
      name 'EditedName'
      source 'https://github.com'
    end
    project.should have_name'EditedName'
    page.should have_link 'View Source'
    page.should have_text 'Project updated successfully'
  end

  scenario 'Edit the list of technologies' do
    exemplar = FactoryGirl.create(:project)
    project = project_on_page(exemplar)
    new_technology = FactoryGirl.create(:technology)
    project.edit do
      technologies [new_technology]
    end
    project.view_project
    project.should have_technologies([new_technology])
  end

  scenario 'Edit project without changing technologies', js: true do
    exemplar = FactoryGirl.create(:project)
    project = project_on_page(exemplar)
    technology = FactoryGirl.create(:technology)
    project.add_technology(technology)
    project.edit do
      name 'EditedName'
    end
    project.should have_technologies([technology])
  end

  def project_on_page(project = nil)
    ProjectOnPage.new(project)
  end
end

feature 'View Projects' do

  scenario 'Visit Show Projects Page' do
    exemplar = FactoryGirl.create(:project)
    project = project_on_page(exemplar)
    2.times do
      project.add_technology FactoryGirl.create(:technology)
    end
    project.view_project
    project.should have_name exemplar.name
    project.should have_description exemplar.description
    project.should have_source_link
    project.technologies.each do |pt|
      page.should have_link pt.name, href: technology_path(pt)
    end
  end

  scenario 'Visit the Index Page' do
    3.times { FactoryGirl.create(:project) }
    visit projects_path
    Project.all.each do |exemplar|
      project = project_on_page(exemplar)
      project.should have_name exemplar.name
      project.should have_technologies exemplar.technologies
    end
  end

  def project_on_page(project)
    ProjectOnPage.new(project)
  end
end
