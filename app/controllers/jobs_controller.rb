class JobsController < ApplicationController
  def index
    @jobs = Job.where(user_id: current_user.id)
  end

  def show
  end

  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @judge = User.find(params[:job][:user_id])
    @job = Job.new(job_params)
    @job.user_id = @judge.id
    @job.portfolio_id =  @portfolio.id
    respond_to do |format|
      if @job.save
        format.html {
          redirect_to @job,
            notice: 'job was successfully created.'
        }
        format.json {
          render json: @job,
            status: :created,
            location: @job
        }
      else
        format.html { render 'new' }
        format.json {
          render json: @job.errors,
            status: :unprocessable_entity
      }
      end
    end
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

  private
  def job_params
    params.require(:job).permit(:user_id, :portfolio_id, :price)
  end
end
