class JobsController < ApplicationController
  def index
    @jobs = Job.where(user_id: current_user.id)
    @portfolios = current_user.portfolios.under_revision
    @sales_balance = Sale.closed_sales.where(job_id: @jobs).sum(:amount)
  end
  def new
    @portfolios = current_user.portfolios
    @judges = User.find(params[:id])
    @price = User::PRICE
    @job = Job.new
  end
  def show
    @job = Job.find(params[:id])
    @portfolios = current_user.portfolios.under_revision
    
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

  #Photo pinching review
  def review
    @job = Job.find(params[:job_id])
    @photo = Photo.find(params[:photo_id])
    @pinch = Pinch.new 
    @pinches = @job.pinches.where(:photo_id => params[:photo_id])
    authorize @job
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
