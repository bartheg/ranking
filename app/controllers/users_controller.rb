class UsersController < ApplicationController

  def index
    @users = User.all
    add_breadcrumb "Users", :users_path

    render :index
  end

  private

  # def user_params
  #   params.require(:user).permit(:role_ids: [])
  # end

end
