class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all
    add_breadcrumb "Users", :users_path

    render :index
  end

  def show
    add_breadcrumb "Users", :users_path
    add_breadcrumb @user.email, @user

  end

  private

  # def user_params
  #   params.require(:user).permit(:role_ids: [])
  # end

  def set_user
    @user = User.find(params[:id])
  end
end
