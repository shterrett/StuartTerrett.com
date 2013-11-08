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

feature "New Projects" do
  include AuthHelper
  before(:each) { http_login }

  scenario "Visit /projects/new" do
    visit '/projects/new'
    page.should have_field "Name"
    page.should have_field "Description"
    page.should have_field "Short Description"
    page.should have_field "project_source"
    page.should have_field "project_technology_tokens"
    page.should have_button "Create Project"
  end

  scenario "Create a project" do
    tech = FactoryGirl.create(:technology)
    visit '/projects/new'
    fill_in "Name", with: "New Project"
    fill_in "Description", with: "And blowing into maximum warp speed, you appeared for an instant to be in two places at once. Sorry, Data. We have a saboteur aboard. Earl Grey tea, watercress sandwiches... and Bularian canapés? Are you up for promotion? Sure. You'd be surprised how far a hug goes with Geordi, or Worf. Now, how the hell do we defeat an enemy that knows us better than we know ourselves? Shields up! Rrrrred alert! Mr. Worf, you do remember how to fire phasers? We know you're dealing in stolen ore. But I wanna talk about the assassination attempt on Lieutenant Worf. Fate protects fools, little children and ships named Enterprise. My oath is between Captain Kargan and myself. Your only concern is with how you obey my orders. Or do you prefer the rank of prisoner to that of lieutenant? Wait a minute - you've been declared dead. You can't give orders around here. Damage report! The Federation's gone; the Borg is everywhere! I'm afraid I still don't understand, sir."
    fill_in "Short Description", with: "We know you're dealing in stolen ore. But I wanna talk about the assassination attempt on Lieutenant Worf. Fate protects fools, little children and ships named Enterprise."
    fill_in 'project_technology_tokens', with: tech.id
    expect do
      click_button "Create Project"
    end.to change(Project, :count).by(1)
    project = Project.last
    project.technologies.length.should == 1
    project.technologies.first.name.should == tech.name
  end

end

feature "Edit Projects" do
  include AuthHelper
  before(:each) { http_login }

  scenario "Visit /projects/:id/edit", js: true do
    project = FactoryGirl.create(:project)
    visit "/projects/#{project.id}/edit"
    page.should have_field "Name"
    page.should have_field "Description"
    page.should have_field "Short Description"
    page.should have_css  "#project_technology_tokens", visible: false
    page.should have_button "Update Project"
  end


  scenario "Technology should be loaded" do
    tech = FactoryGirl.create(:technology)
    project = FactoryGirl.create(:project)
    ProjectTech.create({ technology_id: tech.id, project_id: project.id })
    visit "/projects/#{project.id}/edit"
    page.should have_css("[data-load ='#{[tech].to_json}']")
  end

  scenario 'Edit a project', js: true do
    project = FactoryGirl.create(:project)
    visit "/projects/#{project.id}/edit"
    fill_in 'Name', with: 'EditedName'
    fill_in 'project_source', with: 'https://github.com'
    click_button "Update Project"
    page.should have_text 'EditedName'
    page.should have_link 'View Source'
    page.should have_text 'Project updated successfully'
  end

  scenario "Edit the list of technologies" do
    project = FactoryGirl.create(:project)
    tech = FactoryGirl.create(:technology)
    tech_2 = FactoryGirl.create(:technology, name: "New Technology")
    ProjectTech.create({ technology_id: tech.id, project_id: project.id })
    visit "/projects/#{project.id}/edit"
    fill_in 'project_technology_tokens', with: tech_2.id
    click_button "Update Project"
    project.technologies.should eq([tech_2])
  end

  scenario "Edit project without changing technologies", js: true do
    project = FactoryGirl.create(:project)
    tech = FactoryGirl.create(:technology)
    project.technologies << tech
    visit "/projects/#{project.id}/edit"
    fill_in "Name", with: ""
    click_button "Update Project"
    project.technologies.should include(tech)
  end
end

feature "View Projects" do

  before(:all) do
    project = FactoryGirl.create(:project)
    tech_1 = FactoryGirl.create(:technology)
    tech_2 = Technology.create({ name: "Python", abbreviation: "python" })
    ProjectTech.create({ project_id: project.id, technology_id: tech_1.id })
    ProjectTech.create({ project_id: project.id, technology_id: tech_2.id })
  end

  scenario "Visit Show Projects Page" do
    project = FactoryGirl.create(:project)
    visit "/projects/#{project.id}"
    page.should have_text project.name
    page.should have_text project.description
    page.html.should include(project.source_link)
    project.technologies.each do |pt|
      page.should have_link pt.name, href: technology_path(pt)
    end
  end

  scenario "Visit the Index Page" do
    projects = Project.all
    visit "/projects"
    projects.each do |proj|
      page.should have_text proj.name
      page.should have_text proj.short_description
      page.html.should include(proj.source_link)
    end
    Technology.all.each do |tech|
      page.should have_text tech.name
    end
  end
end
