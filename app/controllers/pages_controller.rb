class PagesController < ApplicationController

  def home
    @header = "Last Matches"
    @reports = Report.all
    add_breadcrumb "Home", :root_path

  end

  def how_it_works
    render :how_it_works
  end

  def admin
  end

end
