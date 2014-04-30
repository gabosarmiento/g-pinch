# == Schema Information
#
# Table name: jobs
#
#  id           :integer          not null, primary key
#  portfolio_id :integer
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Job < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :user
  default_scope { order('created_at DESC') }
  scope :accepted_jobs, -> { with_state(:active) }
  scope :unresponded_jobs, -> { with_state(:inactive) }

#state machine definitions
  state_machine initial: :new do
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
      transition :active => :finished
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
