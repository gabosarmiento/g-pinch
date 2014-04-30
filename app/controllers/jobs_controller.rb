class JobsController < ApplicationController
  def index
    @jobs = Job.where(user_id: current_user.id)
  end

  def show
  end

  def create
  end

  def destroy
  end

  #State machine actions
  def view
     @job = Job.find(params[:job_id])
     @job.view
     redirect_to portfolio_path(@job.portfolio)
  end

  def accept
    @job = Job.find(params[:job_id])
    @job.accept
    redirect_to :back
  end
  def reject
    @job = Job.find(params[:job_id])
    @job.reject
    redirect_to :back
  end
  def complete
    @job = Job.find(params[:job_id])
    @job.complete
    redirect_to :back
  end
end
