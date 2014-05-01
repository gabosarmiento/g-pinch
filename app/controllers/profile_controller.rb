class ProfileController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
    @portfolios = current_user.portfolios
    @judges = User.where(:role => "judge")
    @price = User::PRICE
    @job = Job.new
  end

  def update
  end

  def destroy
  end
end
