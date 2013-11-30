require 'spec_helper'

feature 'Authentication' do

  scenario 'New Employment should be authenticated' do
    visit '/admin/employments/new'
    page.status_code.should == 401
  end

  scenario 'Edit Employments should be authenticated' do
    employment = FactoryGirl.create(:employment)
    visit "/admin/employments/#{employment.id}/edit"
    page.status_code.should == 401
  end

  scenario 'Show Employment should not be authenticated' do
    employment = FactoryGirl.create(:employment)
    visit "/employments/#{employment.id}"
    page.status_code.should == 200
  end

  scenario 'Index Employments should not be authenticated' do
    visit '/resume'
    page.status_code.should == 200
  end

end

feature 'Employments as Admin' do
  scenario 'Create New Employment', js: true do
    employment = employment_on_page
    employment.create do
      company 'Millennium Partners Sports Club Management'
      position 'Web Application Developer'
      description 'Lorem Ipsum'
      start_date 2.years.ago
      end_date 1.year.ago
      website 'http://sportsclubla.com'
    end
    employment.should have_success_message(:create)
  end

  scenario 'Create Employment and associate with technologies' do
    technology = FactoryGirl.create(:technology)
    employment = employment_on_page
    employment.create do
      company 'Millennium Partners Sports Club Management'
      position 'Web Application Developer'
      description 'Lorem Ipsum'
      start_date 2.years.ago
      end_date 1.year.ago
      website 'http://sportsclubla.com'
      technologies [technology]
      projects []
    end
    employment.should have_success_message(:create)
    employment.should have_technologies [technology]
  end

  scenario 'Create Employment and associate with projects' do
    project = FactoryGirl.create(:project)
    employment = employment_on_page
    employment.create do
      company 'Millennium Partners Sports Club Management'
      position 'Web Application Developer'
      description 'Lorem Ipsum'
      start_date 2.years.ago
      end_date 1.year.ago
      website 'http://sportsclubla.com'
      projects [project]
      technologies []
    end
    employment.should have_success_message(:create)
    employment.should have_projects [project]
  end

  scenario 'Update Employment', js: true do
    exemplar =  FactoryGirl.create(:employment)
    employment = employment_on_page(exemplar)
    employment.edit do
      description 'Lorem Ipsum Edited'
    end
    employment.should have_success_message(:update)
    employment.should have_description 'Lorem Ipsum Edited'
  end

  scenario 'Update Employment without changing projects or technologies', js: true do
    exemplar = FactoryGirl.create(:employment)
    technology = FactoryGirl.create(:technology)
    project = FactoryGirl.create(:project)
    exemplar.projects << project
    exemplar.technologies << technology
    employment = employment_on_page(exemplar)
    employment.edit do
      description 'Lorem Ipsum Edited'
    end
    employment.should have_technologies([technology])
    employment.should have_projects([project])
  end

  scenario 'Update Employment Technologies' do
    exemplar = FactoryGirl.create(:employment)
    technology = FactoryGirl.create(:technology)
    technology_2 = FactoryGirl.create(:technology)
    exemplar.technologies << technology
    employment = employment_on_page(exemplar)
    employment.edit do
      projects []
      technologies [technology_2]
    end
    employment.should have_technologies([technology_2])
  end

  scenario 'Update Employment Projects' do
    exemplar = FactoryGirl.create(:employment)
    project = FactoryGirl.create(:project)
    project_2 = FactoryGirl.create(:project)
    exemplar.projects << project
    employment = employment_on_page(exemplar)
    employment.edit do
      projects [project_2]
      technologies []
    end
    employment.should have_projects([project_2])
  end
end

feature 'Resume' do
  include ApplicationHelper

  scenario 'Visit Resume page' do
    exemplar = FactoryGirl.create(:employment, start_date: 1.year.ago)
    employment = employment_on_page(exemplar)
    employment.view_resume
    employment.should have_company(exemplar.company)
    employment.should have_description(exemplar.description)
    employment.should have_url(exemplar.url)
    employment.should have_position(exemplar.position)
    employment.should have_start_date
    employment.should have_end_date
  end

end

feature 'View Employment' do

  it 'should show details of employment' do
    exemplar = Employment.create({
      company: 'Millennium Partners Sports Club Management',
      position: 'Web Application Developer',
      start_date: '2012-10-01',
      end_date: '2014-09-30',
      url: 'http://sportsclubla.com',
      description: """#Backend Web Applications
      + Custom Sitefinity Modules for company website and all clubs
      + Web App for Private Trainers to track sessions with clients
      + gem and backend for Group Ex Scheduling that consumes APIs from CSI SpectrumNG"""
    })
    employment = employment_on_page(exemplar)
    employment.view_employment
    employment.should have_company(exemplar.company)
    employment.should have_description(exemplar.description)
    employment.should have_url(exemplar.url)
    employment.should have_position(exemplar.position)
    employment.should have_start_date
    employment.should have_end_date
  end

  it 'should list technologies associated with employment' do
    exemplar = FactoryGirl.create(:employment)
    technology = FactoryGirl.create(:technology)
    exemplar.technologies << technology
    employment = employment_on_page(exemplar)
    employment.view_employment
    employment.should have_technologies_on_page([technology])
  end

  it 'should list projects associated with employment' do
    exemplar = FactoryGirl.create(:employment)
    project = FactoryGirl.create(:project)
    exemplar.projects << project
    employment = employment_on_page(exemplar)
    employment.view_employment
    employment.should have_projects_on_page([project])
  end
end

def employment_on_page(employment = nil)
  EmploymentOnPage.new(employment)
end
