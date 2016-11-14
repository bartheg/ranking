require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the GamesHelper. For example:
#
# describe GamesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe GamesHelper, type: :helper do

  # describe '.link_to_game_laders' do
  #   subject { Game.new(full_name: 'The Wattle for Besnod',
  #               short_name: 'Besnod',
  #               description: 'Lelum polelum',
  #               simultaneous_turns: false)}
  #
  #   let!(:ranking1) {Ranking.new(name: 'Ranking1',
  #               description: 'This is fake Ranking. All results are fake here',
  #               game_id: 1)}
  #   let!(:ranking2) {Ranking.new(name: 'Ranking2',
  #               description: 'This is fake Ranking. All results are fake here',
  #               game_id: 2)}
  #   let!(:ranking3) {Ranking.new(name: 'Ranking3',
  #               description: 'This is fake Ranking. All results are fake here',
  #               game_id: 1)}
  #   it 'returns number of rankingsand link if number is greater then zero' do
  #     expect(link_to_game_laders ubject).to eq {link_to 2, game_rankings_path(subject.id)}
  #   end
  # end

end
