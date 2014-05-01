class StripeMailer < ActionMailer::Base
  default from: 'g@pepperpinch.com'
  def admin_dispute_created(charge)
    @charge = charge
    @sale = Sale.find_by(stripe_id: @charge.id)
    if @sale
      mail(to: 'g@pepperpinch.com', subject: "Dispute created on charge #{@sale.guid} (#{charge.id})").
    deliver
    end 
  end
  def admin_charge_succeeded(charge)
    @charge = charge
    mail(to: 'g@pepperpinch.com', subject: 'Woo! Charge Succeeded!')
  end
  def receipt(charge)
    @charge = charge
    @sale = Sale.find_by!(stripe_id: @charge.id)
    mail(to: @sale.email, subject: "Thanks for hiring #{@sale.job.user.name}")
end
end