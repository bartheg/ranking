FactoryGirl.define do

# USERS

  factory :user_from_china, class: User do
    email "china@china.zh"
    password "asdqwe123ASD"
  end

  factory :user_from_poland, class: User do
    email "poland@poland.pl"
    password "asd3we12ASD"
  end

# PROFILES

  factory :sun_tzu, class: Profile do
    name "Sun_Tzu"
    description "Ni hao"
    color '#dddd11'
  end

  factory :mao, class: Profile do
    name "Mao"
    description "I love communism and cannibalism."
    color '#dd0000'
  end

  factory :panther, class: Profile do
    name "pantherSS-88"
    description "siema kto pl"
    color '#dd1111'
  end



end
