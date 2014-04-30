class TransactionsController < ApplicationController
  skip_before_action :authenticate_user!,
  only: [:new, :create]

  def new
    @job = Job.find_by!(
    user_id: params[:user_id]
  )
  end

  def create
    job = Job.find_by!(
    user_id: params[:user_id]
    )
    token = params[:stripeToken]
    begin
      charge = Stripe::Charge.create(
        amount:      job.price,
        currency:    "usd",
        card:        token,
        description: params[:email]
        )
        @sale = job.sales.create!(
          email:      params[:email]
        )
        redirect_to pickup_url(guid: @sale.guid)
    rescue Stripe::CardError => e
        # The card has been declined or
        # some other error has occurred
        @error = e
        render :new
    end
  end

  def pickup
    @sale = Sale.find_by!(guid: params[:guid])
    @job = @sale.job
  end

end
