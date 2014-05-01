class JobsController < ApplicationController
  def index
    @jobs = Job.where(user_id: current_user.id)
    
  end
  def new
    @portfolios = current_user.portfolios
    @judges = User.find(params[:id])
    @price = User::PRICE
    @job = Job.new
  end
  def show
    @job = Job.find(params[:id])
  end

  def create
    @judges = User.where(:role => "judge")
    @portfolios = current_user.portfolios
    @portfolio = Portfolio.find(params[:job][:portfolio_id])
    @judge = User.find(params[:job][:user_id])
    @job = @portfolio.jobs.create(user_id: @judge.id)
    @job.price_cents = User::PRICE
     if @job.save
        respond_to do |format|
          format.html {
            redirect_to @job,
            notice: 'Job was successfully created'
          }
        end
      end

    #   flash[:notice] = "Job was saved"
    #   redirect_to @job
    # else
    #   flash[:error] = "There was an error saving the job"
    #   render "new"
        # respond_to do |f|
        #   f.html { redirect_to @job}
        # end
    
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
    params.require(:job).permit(:user_id, :portfolio_id, :price_cents)
  end
end
