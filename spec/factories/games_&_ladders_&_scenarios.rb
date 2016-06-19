FactoryGirl.define do

# GAMES

  factory :wesnoth, class: Game do
    full_name "The Battle for Wesnoth"
    short_name  "Wesnoth"
    description "The Battle for Wesnoth is a Free, turn-based tactical strategy game with a high fantasy theme, featuring both single-player, and online/hotseat multiplayer combat. More on www.wesnoth.org"
    simultaneous_turns false
  end

# LADDERS

  factory :wesnoth_ladder, class: Ladder do
    name  "Wesnoth Standard Ladder"
    description "Blah bla blha, this is a standard Wesnoth ladder."
  end

  factory :wesnoth_blitz_ladder, class: Ladder do
    name  "Wesnoth Blitz Ladder"
    description "Blah bla blha, this is a blitz Wesnoth ladder."
  end

# POSSIBLE RESULTS

  factory :victory, class: PossibleResult do
    score_factor 100
    description "Well-deserved Victory!"
  end

  factory :defeat, class: PossibleResult do
    score_factor 0
    description "Unlucky Defeat"
  end

  factory :draw, class: PossibleResult do
    score_factor 50
    description "Draw"
  end

# SCENAROIS

  factory :freelands, class: Scenario do
    full_name 'The Freelands'
    short_name 'The Freelands'
    description 'The Freelands is a map with three ways to the enemy castle.'
    mirror_matchups_allowed true
    map_size nil
    map_random_generated false
  end

  factory :basilisk, class: Scenario do
    full_name 'Caves of the Basilisk'
    short_name 'Caves of the Basilisk'
    description 'Caves of the Basilisk is a map.'
    mirror_matchups_allowed true
    map_size nil
    map_random_generated false
  end

# CONFIGS

  factory :default_config, class: DefaultLadderConfig do
    default_ranking 1500
    max_distance_between_players 1000
    min_points_to_gain 2
    disproportion_factor 10
    unexpected_result_bonus 15
    hours_to_confirm 49
    is_default true
  end

end
