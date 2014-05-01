# == Schema Information
#
# Table name: sales
#
#  id              :integer          not null, primary key
#  job_id          :integer
#  email           :string(255)
#  guid            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  state           :string(255)
#  stripe_id       :string(255)
#  stripe_token    :string(255)
#  card_expiration :date
#  error           :text
#  fee_amount      :integer
#  amount          :integer
#

class Sale < ActiveRecord::Base
  has_paper_trail
  belongs_to :job
  before_create :populate_guid

  state_machine initial: :pending do

    event :process do 
      transition :pending => :processing
    end
    after_transition :pending => :processing, :do => :charge_card
    
    event :finish do
      transition :processing => :finished
    end

    event :fail do 
      transition :processing => :errored
    end

  end

  def charge_card
    begin
      save!
      charge = Stripe::Charge.create(
      amount: self.amount,
      currency: "usd",
        card: self.stripe_token,
        description: self.email,
      )
     balance = Stripe::BalanceTransaction.retrieve(charge.balance_transaction)
      self.update(
        stripe_id:       charge.id,
        card_expiration: Date.new(charge.card.exp_year, charge.card.exp_month, 1),
        fee_amount:      balance.fee
      )
      self.finish!
      rescue Stripe::StripeError => e
      self.update_attributes(error: e.message)
      self.fail!
    end
  end
  private
  def populate_guid
    self.guid = SecureRandom.uuid()
  end
end
