FactoryGirl.define do
  factory :employment do
    company "Camelot"
    position "Archmage of the realm"
    description "MyText"
    sequence(:start_date) { |n| "#{1199 + n}-01-06" }
    sequence(:end_date) { |n| "#{1200 + n}-01-06" }
    url "http://google.com"
  end

  factory :project do
    sequence(:name) { |n| "Rails App-#{n}" }
    description "Well, I'll say this for him - he's sure of himself. Is it my imagination, or have tempers become a little frayed on the ship lately? Captain, why are we out here chasing comets? In all trust, there is the possibility for betrayal. I'm afraid I still don't understand, sir. Flair is what marks the difference between artistry and mere competence. Maybe we better talk out here; the observation lounge has turned into a swamp. Mr. Worf, you sound like a man who's asking his friend if he can start dating his sister. Well, that's certainly good to know. Yes, absolutely, I do indeed concur, wholeheartedly! Talk about going nowhere fast. This should be interesting. Not if I weaken first. When has justice ever been as simple as a rule book? I'll be sure to note that in my log. Your shields were failing, sir. But the probability of making a six is no greater than that of rolling a seven. You enjoyed that. Mr. Crusher, ready a collision course with the Borg ship. Fear is the true enemy, the only enemy."
    short_description 'And blowing into maximum warp speed, you appeared for an instant to be in two places at once. Sorry, Data. We have a saboteur aboard.'
    source  'http://github.com'

    factory :closed_project do
      source 'Closed'
    end
  end

  factory :technology do
    sequence(:name) { |n| "Language-#{n}" }
    abbreviation 'ruby'
    description "You bet I'm agitated! I may be surrounded by insanity, but I am not insane. You enjoyed that. Fate protects fools, little children and ships named Enterprise. Now we know what they mean by 'advanced' tactical training. Earl Grey tea, watercress sandwiches... and Bularian canapés? Are you up for promotion?"

    after(:create) do |technology|
      technology.projects << FactoryGirl.create(:project)
    end
  end

  factory :post do
    sequence(:title) { |n| "Blog Post #{n}" }
    body "Wouldn't that bring about chaos? Ensign Babyface! Flair is what marks the difference between artistry and mere competence. Damage report! You did exactly what you had to do. You considered all your options, you tried every alternative and then you made the hard choice. Some days you get the bear, and some days the bear gets you. Maybe if we felt any human loss as keenly as we feel one of those close to us, human history would be far less bloody. The look in your eyes, I recognize it. You used to have it for me. Mr. Worf, you sound like a man who's asking his friend if he can start dating his sister. I can't. As much as I care about you, my first duty is to the ship. Now we know what they mean by 'advanced' tactical training. Besides, you look good in a dress."
  end
end
