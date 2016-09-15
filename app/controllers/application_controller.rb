class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_action :get_profiles, :set_profile_color, :set_profile_name, :set_reports_to_confirm_number
  protect_from_forgery with: :exception


  private

  def get_profiles
    if current_user
      @my_profiles = current_user.profiles
    end
  end

  def set_reports_to_confirm_number
    if current_user
      @reports_to_confirm_number = Report.to_confirm_by_user(current_user)
    end
  end

  def set_profile_color
    @profile_color = '#444444'
    if current_user
      if current_user.current_profile
        @profile_color = current_user.current_profile.color
      end
    end
  end

  def set_profile_name
    @profile_name = 'PROFILE_NOT_CREATED'
    if current_user
      if current_user.current_profile
        @profile_name = current_user.current_profile.name
      end
    end
  end

end
