# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :technology do
    sequence(:name) { |n| "Language-#{n}" }
    abbreviation "ruby"
    
    factory :tech_with_desc do
      description "You bet I'm agitated! I may be surrounded by insanity, but I am not insane. You enjoyed that. Fate protects fools, little children and ships named Enterprise. Now we know what they mean by 'advanced' tactical training. Earl Grey tea, watercress sandwiches... and Bularian canapés? Are you up for promotion?"
    end
    
  end
end
