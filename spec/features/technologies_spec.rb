require 'spec_helper'

feature 'Authentication' do

  scenario 'New Technology should be authenticated' do
    visit '/technologies/new'
    page.status_code.should == 401
  end

  scenario 'Edit Technology should be authenticated' do
    technology = FactoryGirl.create(:technology)
    visit "/technologies/#{technology.id}/edit"
    page.status_code.should == 401
  end

  scenario 'Show Technology should not be authenticated' do
    technology = FactoryGirl.create(:technology)
    visit "/technologies/#{technology.id}"
    page.status_code.should == 200
  end

  scenario 'Index Technologies should not be authenticated' do
    visit '/technologies'
    page.status_code.should == 200
  end

end

feature 'Technology admin' do
  scenario 'create new technology' do
    technology = technology_on_page
    technology.create do
      name 'New Technology'
      abbreviation 'newtech'
      description 'Really cool technology'
    end
    technology.view_technology
    technology.should have_name('New Technology')
    technology.should have_description('Really cool technology')
  end

  scenario 'edit technology' do
    exemplar = FactoryGirl.create(:technology)
    technology = technology_on_page(exemplar)
    technology.edit do
      name 'EditedName'
    end
    technology.view_technology
    technology.should have_name 'EditedName'
  end

  def technology_on_page(technology = nil)
    TechnologyOnPage.new(technology)
  end
end

feature 'View Technology' do
  scenario 'visit show technology page' do
    exemplar = FactoryGirl.create(:technology)
    technology = technology_on_page(exemplar)

    technology.view_technology

    technology.should have_name exemplar.name
    technology.should have_description exemplar.description
    technology.should have_project exemplar.projects.first
  end

  scenario 'visit technology index page' do
    technology_1 = FactoryGirl.create(:technology)
    technology_2 = FactoryGirl.create(:technology)
    visit technologies_path
    page.should have_link technology_1.name,
      href: technology_path(technology_1)
    page.should have_link technology_2.name,
      href: technology_path(technology_2)
  end

  def technology_on_page(technology = nil)
    TechnologyOnPage.new(technology)
  end
end
