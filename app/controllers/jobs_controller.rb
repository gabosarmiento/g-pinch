class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
  end

  def create
  end

  def destroy
  end
end
