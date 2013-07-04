FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "Rails App-#{n}" }
    description "Well, I'll say this for him - he's sure of himself. Is it my imagination, or have tempers become a little frayed on the ship lately? Captain, why are we out here chasing comets? In all trust, there is the possibility for betrayal. I'm afraid I still don't understand, sir. Flair is what marks the difference between artistry and mere competence. Maybe we better talk out here; the observation lounge has turned into a swamp. Mr. Worf, you sound like a man who's asking his friend if he can start dating his sister. Well, that's certainly good to know. Yes, absolutely, I do indeed concur, wholeheartedly! Talk about going nowhere fast. This should be interesting. Not if I weaken first. When has justice ever been as simple as a rule book? I'll be sure to note that in my log. Your shields were failing, sir. But the probability of making a six is no greater than that of rolling a seven. You enjoyed that. Mr. Crusher, ready a collision course with the Borg ship. Fear is the true enemy, the only enemy."
    short_description "And blowing into maximum warp speed, you appeared for an instant to be in two places at once. Sorry, Data. We have a saboteur aboard."
    source  "http://github.com"    
  
    factory :closed_project do
      source "Closed"
    end
    
  end
    
end