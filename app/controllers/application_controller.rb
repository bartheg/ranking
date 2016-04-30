class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_action :get_profiles

  protect_from_forgery with: :exception


  private

  def get_profiles
    if current_user
      @profiles = current_user.profiles
    end
  end


end
