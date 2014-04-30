class ProfileController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def show
  end

  def update
  end

  def destroy
  end
end
