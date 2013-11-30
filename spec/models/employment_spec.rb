require 'spec_helper'

describe Employment do
  describe 'Validations' do

    let(:employment) { FactoryGirl.build(:employment) }

    it 'should require [:company, :position, :description, :start_date, :end_date] to be present' do
      [:company, :position, :description, :start_date, :end_date].each do |atrb|
        arg = "#{atrb}="
        employment.send(arg, nil)
        employment.should_not be_valid
      end
    end

  end

  describe 'Sorting' do
    it 'should automatically sort by descending start date' do
      10.times { FactoryGirl.create(:employment) }
      employments = Employment.all
      employments[0].start_date.should > employments[1].start_date
      employments[6].start_date.should > employments[7].start_date
    end
  end

  describe 'Relationships' do

    let(:employment) { FactoryGirl.create(:employment) }

    it 'should have_many technologies' do
      technology = FactoryGirl.create(:technology)
      employment.technologies << technology
      employment.reload
      employment.technologies.first.should == technology
    end

    it 'returns an array of associated technology ids' do
      technology = FactoryGirl.create(:technology)
      employment.technologies << technology
      employment.technology_tokens.should == [technology.id]
      employment.technology_ids.should == employment.technology_tokens
    end

    it 'parses a string of technology ids' do
      3.times { FactoryGirl.create(:technology) }
      technology_ids = Technology.all.pluck(:id)
      employment.technology_tokens = technology_ids.join(',')
      employment.technology_ids.should == technology_ids
    end

    it 'should have_many projects' do
      project = FactoryGirl.create(:project)
      employment.projects << project
      employment.reload
      employment.projects.first.should == project
    end

    it 'returns an array of associated project ids' do
      project = FactoryGirl.create(:project)
      employment.projects << project
      employment.project_tokens.should == [project.id]
      employment.project_ids.should == employment.project_tokens
    end

    it 'parses a string of project ids' do
      3.times { FactoryGirl.create(:project) }
      project_ids = Project.all.pluck(:id).join(',')
      employment.project_tokens = project_ids
      employment.project_ids.should == project_ids.split(',').map(&:to_i)
    end
  end

  describe 'formatting' do

    let(:employment) { FactoryGirl.build(:employment) }

    it 'should format date for the resume as "Month Year"' do
      employment.start_date = DateTime.parse('2000-01-01')
      employment.end_date = DateTime.parse('2001-12-31')
      start_date = employment.format_date(:start_date)
      start_date.should == 'Jan 2000'
      end_date = employment.format_date(:end_date)
      end_date.should == 'Dec 2001'
    end

    it 'should format a date earler than 1000AD as "Current"' do
      employment.end_date = DateTime.parse("0001-01-01")
      employment.format_date(:end_date).should == 'Current'
    end

    it 'should give "name" as "position | company"' do
      employment.name.should == "#{employment.position} | #{employment.company}"
    end
  end
end
