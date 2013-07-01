require 'spec_helper'

feature "New Projects" do
  
  scenario "Visit /projects/new" do
    visit '/projects/new'
    page.should have_field "Name"
    page.should have_field "Description"
    page.should have_field "Short Description"
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
    page.should have_button "Update Project"
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
  
end
  
  