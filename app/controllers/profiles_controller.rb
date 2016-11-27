class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :switch_to]
  # before_action :find_user, only: [:index]

  # GET /profiles
  def index

    if params[:user_id]
      @param_user_id = params[:user_id].to_i
      @user = User.find @param_user_id
      if current_user
        @profiles = @user.profiles
        if current_user.id == @param_user_id
          add_breadcrumb "My Account", @user
          add_breadcrumb "profiles", user_profiles_path(@user)
          render :index_my
        else
          add_breadcrumb "User: #{@user.email}", @user
          add_breadcrumb "profiles", user_profiles_path(@user)
          render :index_not_my
        end
      end
    else
      @profiles = Profile.all
      add_breadcrumb "Profiles", :profiles_path
      render :index_all
    end

  end

  # GET /profiles/1
  def show
    @languages = @profile.languages
    add_breadcrumb "Profiles", :profiles_path
    add_breadcrumb @profile.name, @profile
    if current_user
      if current_user.id == @profile.user_id
        render :show_my
      else
        render :show_not_my
      end
    else
      render :show_not_my
    end

  end


  def switch_to
    @profile.make_default
    redirect_to :back
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    @languages = @profile.languages

  end

  # POST /profiles
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to @profile, notice: 'Profile was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /profiles/1
  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /profiles/1
  def destroy
    @profile.destroy
    redirect_to profiles_url, notice: 'Profile was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def profile_params
    params.require(:profile).permit(:name, :description, :color, language_ids: [])
  end

  def find_user
    if params[:user_id] && current_user
      if params[:user_id].to_i == current_user.id
        @user = User.find params[:user_id]
      end
    end
  end

end
