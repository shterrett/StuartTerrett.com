require 'spec_helper'

describe Employment do

  describe "Validations" do
  
    let(:employment) { FactoryGirl.build(:employment) }
  
    it "should require [:company, :position, :description, :start_date, :end_date] to be present" do
      [:company, :position, :description, :start_date, :end_date].each do |atrb|
        arg = "#{atrb}="
        employment.send(arg, nil)
        employment.should_not be_valid
      end
    end
    
  end
  
  describe "Sorting" do
    
    before(:all) do
      10.times { FactoryGirl.create(:employment) }
    end
    after(:all) { Employment.destroy_all }
    
    it "should automatically sort by descending start date" do
      employments = Employment.all
      employments[0].start_date.should > employments[1].start_date
      employments[6].start_date.should > employments[7].start_date
    end
    
  end
  
end
