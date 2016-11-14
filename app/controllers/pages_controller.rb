class PagesController < ApplicationController

  def home
    @header = "Last Matches"
    @reports = Report.all

  end

  def how_it_works
    render :how_it_works
  end

  def admin
  end

end
