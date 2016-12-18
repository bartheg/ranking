class Game < ActiveRecord::Base
  has_many :rankings
  has_many :scenarios, through: :rankings
  has_many :ranked_positions, through: :rankings
  has_many :reports, through: :scenarios
  has_many :factions
  has_many :possible_results

  accepts_nested_attributes_for :possible_results, reject_if: :all_blank, allow_destroy: true

  resourcify

  def count_reports
    number_of_reports = 0
    self.rankings.each do |ranking|
       ranking.scenarios.each do |scenario|
         scenario.reports.each do |report|
           number_of_reports += 1
         end
       end
    end
    number_of_reports
  end

end
