class ProfileController < ApplicationController
  def index
    @profiles = Profile.all.approved
  end

  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
    @portfolios = current_user.portfolios
    @judges = User.where(:role => "judge")
    @price = User::PRICE
    @job = Job.new
    authorize @profile 
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
