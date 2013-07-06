# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employment do
    company "Camelot"
    position "Archmage of the realm"
    description "MyText"
    sequence(:start_date) { |n| "#{1199 + n}-01-06" }
    sequence(:end_date) { |n| "#{1200 + n}-01-06" }
    url "http://google.com"
  end
end
