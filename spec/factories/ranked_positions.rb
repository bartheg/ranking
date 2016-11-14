FactoryGirl.define do
  factory :ranked_position do
    ranking nil
    profile nil
    last_score 1
    last_score_change 1
    last_match_at "2016-09-05 17:43:00"
    number_of_confirmed_matches 1
    number_of_won_matches 1
    scores_from_wins 1
    average_win_score 1
  end
end
