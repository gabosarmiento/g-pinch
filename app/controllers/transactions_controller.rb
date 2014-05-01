class TransactionsController < ApplicationController
  skip_before_action :authenticate_user!,
  only: [:new, :create]

  def new
    # @job = Job.find_by!(user_id: params[:job][:user_id])
  end

  def create
    @job = Job.find_by!(user_id: params[:user_id])
    
    sale = @job.sales.create(
       amount: @job.price_cents,
       email: params[:stripeEmail], 
       stripe_token:  params[:stripeToken]
      )
    sale.process!
      if sale.finished?
        redirect_to pickup_url(guid: sale.guid)
      else
        flash.now[:alert] = sale.error
        render :new
      end
  end

  def pickup
    @sale = Sale.find_by!(guid: params[:guid])
    @job = @sale.job
  end

end
