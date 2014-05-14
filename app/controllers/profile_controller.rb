class ProfileController < ApplicationController
  def index
    @profiles = Profile.all.approved
    authorize @profiles
  end

  def show
    @profile = Profile.find(params[:id])
    authorize @profile 
    @user = @profile.user
    @portfolios = current_user.portfolios
    @judges = User.where(:role => "judge")
    @price = User::PRICE
    @job = Job.new
  end

  def update
    @profile = current_user.profile
    authorize @profile 
  end

  def destroy
  end

  private
  def profile_params
    params.require(:profile)
  end
end
