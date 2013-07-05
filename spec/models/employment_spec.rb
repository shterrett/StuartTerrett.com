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
  
end
