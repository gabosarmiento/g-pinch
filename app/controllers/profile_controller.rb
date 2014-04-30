class ProfileController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
  end

  def update
  end

  def destroy
  end
end
