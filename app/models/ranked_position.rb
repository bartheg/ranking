class RankedPosition < ActiveRecord::Base
  belongs_to :ladder
  belongs_to :profile
end
