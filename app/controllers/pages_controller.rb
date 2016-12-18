class PagesController < ApplicationController

  def home
    @header = "Last Matches"
    @reports = Report.all
    add_breadcrumb "Home", :root_path

# for most_popular_games
    @number_of_most_popular_games = 2
    @games = Game.all.sort_by { |game| game.count_reports }
    @games = @games.first(@number_of_most_popular_games)

  end

  def how_it_works
    render :how_it_works
  end

  def admin
  end

end
