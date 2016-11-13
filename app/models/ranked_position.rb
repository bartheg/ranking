class RankedPosition < ActiveRecord::Base
  belongs_to :ranking
  belongs_to :profile
end
