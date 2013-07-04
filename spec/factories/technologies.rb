# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :technology do
    sequence(:name) { |n| "Language-#{n}" }
    abbreviation "ruby"
  end
end
