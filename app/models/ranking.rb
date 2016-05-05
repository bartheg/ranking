class Ranking < ActiveRecord::Base
  belongs_to :ladder
  belongs_to :profile
  belongs_to :report
end
