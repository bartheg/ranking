FactoryGirl.define do

  factory :wesnoth, class: Game do
    full_name "The Battle for Wesnoth"
    short_name  "Wesnoth"
    description "Blah bla blha, Wesnoth is a game."
    simultaneous_turns false
  end

  factory :fog, class: Game do
    full_name "Field of Glory"
    short_name  "FoG"
    description "Blah bla blha, FoG is a game."
    simultaneous_turns false
  end


end
