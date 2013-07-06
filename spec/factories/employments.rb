# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employment do
    company "Camelot"
    position "Archmage of the realm"
    description "MyText"
    start_date "1065-01-06"
    end_date "1200-01-06"
    url "http://google.com"
  end
end
