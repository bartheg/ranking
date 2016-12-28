class PagesController < ApplicationController

  def home
    add_breadcrumb "Home", :root_path

# for last_matches
    @max_number_of_last_marches = 4
    @reports = Report.last(@max_number_of_last_marches)
    @number_of_last_marches = @reports.count
# for most_popular_games
    @max_number_of_most_popular_games = 2
    @games = Game.all.sort_by { |game| game.count_reports }
    @games = @games.first(@max_number_of_most_popular_games)
    @number_of_most_popular_games = @games.count
  end

  def how_it_works
    render :how_it_works
  end

  def admin
  end

end
