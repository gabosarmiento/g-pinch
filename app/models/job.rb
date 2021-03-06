# == Schema Information
#
# Table name: jobs
#
#  id           :integer          not null, primary key
#  portfolio_id :integer
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  state        :string(255)
#  price_cents  :integer
#

StateMachine::Machine.ignore_method_conflicts = true
class Job < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :user
  has_many :sales
  has_many :pinches, -> { order("position ASC") }, dependent: :destroy
  default_scope { order('created_at DESC') }
  scope :current_jobs, -> { with_state(:active) }
  scope :unresponded_jobs, -> { with_state(:inactive) }
  scope :completed, -> { with_state(:completed) }

  validates_numericality_of :price_cents,
    greater_than: 49,
    message: "must be at least 50 cents"

#state machine definitions
  state_machine initial: :created do
    event :purchase do
        transition :created => :new
    end

    event :view do
      transition :new => :seen
    end
    event :accept do 
      transition :seen => :active
    end
    event :reject do
      transition :seen => :canceled
    end
    event :unresponded do
      transition :new => :inactive
    end
    event :complete do
      transition :active => :completed
    end
  end

  #Automated process for inactivity
  def set_unattended_to_inactive
    @jobs = job.all
    @jobs.each do |job|
      if (job.created_at + 7.days) < Time.now && job.new?
        job.unresponded
      end
    end
  end

end
