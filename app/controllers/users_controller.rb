class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  private

  # def user_params
  #   params.require(:user).permit(:role_ids: [])
  # end

end
