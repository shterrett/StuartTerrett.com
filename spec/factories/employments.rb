# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employment do
    company "Camelot"
    position "Archmage of the realm"
    description "MyText"
    start_date "Fall 1056"
    end_date "Current"
  end
end
