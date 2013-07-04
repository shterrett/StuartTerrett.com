require 'spec_helper'

feature "New Projects" do
  
  scenario "Visit /projects/new" do
    visit '/projects/new'
    page.should have_field "Name"
    page.should have_field "Description"
    page.should have_field "Short Description"
    page.should have_select "project_technologies"
    page.should have_button "Create Project"
  end
  
  scenario "Create a project" do
    tech = FactoryGirl.create(:technology)
    visit '/projects/new'
    fill_in "Name", with: "New Project"
    fill_in "Description", with: "And blowing into maximum warp speed, you appeared for an instant to be in two places at once. Sorry, Data. We have a saboteur aboard. Earl Grey tea, watercress sandwiches... and Bularian canapés? Are you up for promotion? Sure. You'd be surprised how far a hug goes with Geordi, or Worf. Now, how the hell do we defeat an enemy that knows us better than we know ourselves? Shields up! Rrrrred alert! Mr. Worf, you do remember how to fire phasers? We know you're dealing in stolen ore. But I wanna talk about the assassination attempt on Lieutenant Worf. Fate protects fools, little children and ships named Enterprise. My oath is between Captain Kargan and myself. Your only concern is with how you obey my orders. Or do you prefer the rank of prisoner to that of lieutenant? Wait a minute - you've been declared dead. You can't give orders around here. Damage report! The Federation's gone; the Borg is everywhere! I'm afraid I still don't understand, sir."
    fill_in "Short Description", with: "We know you're dealing in stolen ore. But I wanna talk about the assassination attempt on Lieutenant Worf. Fate protects fools, little children and ships named Enterprise."
    select tech.name, from: "project_technologies"
    expect do
      click_button "Create Project"
    end.to change(Project, :count).by(1)
    project = Project.last
    project.technologies.length.should == 1
    project.technologies.first.name.should == tech.name
  end
  
end

feature "Edit Projects" do
  
  before(:all) { FactoryGirl.create(:project) }
  
  scenario "Visit /projects/:id/edit" do
    project = Project.all.first
    visit "/projects/#{project.id}/edit"
    page.should have_field "Name"
    page.should have_field "Description"
    page.should have_field "Short Description"
    page.should have_select "project_technologies"
    page.should have_button "Update Project"
  end
  
  scenario "Technology should be selected" do
    tech = FactoryGirl.create(:technology)
    project = Project.all.last
    ProjectTech.create({ technology_id: tech.id, project_id: project.id })
    visit "/projects/#{project.id}/edit"
    page.should have_select "project_technologies", selected: tech.name
  end
  
  scenario "Edit a project" do
    project = Project.all.first
    visit "/projects/#{project.id}/edit"
    fill_in "Name", with: "EditedName"
    click_button "Update Project"
    edited_project = Project.find(project.id)
    edited_project.name.should == "EditedName"
    page.should have_text "Project updated successfully"
  end
  
  scenario "Edit the list of technologies" do
    project = Project.all.first
    tech = FactoryGirl.create(:technology)
    tech_2 = FactoryGirl.build(:technology)
    tech_2.name = "New Technology"
    tech_2.save
    ProjectTech.create({ technology_id: tech.id, project_id: project.id })
    visit "/projects/#{project.id}/edit"
    unselect tech.name, from: "project_technologies"
    select tech_2.name, from: "project_technologies"
    click_button "Update Project"
    project.technologies.should include(tech_2)
    project.technologies.should_not include(tech)
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
    project = Project.all.last
    visit "/projects/#{project.id}"
    page.should have_text project.name
    page.should have_text project.description
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
    end
    Technology.all.each do |tech|
      page.should have_text tech.name
    end
  end
  
end
    
  