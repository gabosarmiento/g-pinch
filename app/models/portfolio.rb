# == Schema Information
#
# Table name: portfolios
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  public     :boolean
#  valuation  :float
#  needs      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  state      :string(255)
#

class Portfolio < ActiveRecord::Base

  has_many :photos, dependent: :destroy
  has_many :jobs
  belongs_to :user
  scope :visible, -> { where(public: true) }
  default_scope { order('created_at DESC') }
  scope :under_revision, -> { with_state(:commissioned) }

  def self.names
    pluck(:name)
  end

  #state machine definition 
  state_machine initial: :draft do
    event :assign do
      transition :draft => :commissioned
    end

    event :cancel do
      transition :commissioned => :hidden
    end

    event :resume do
      transition :hidden => :commissioned
    end

    event :unpublish do
      transition :commissioned => :draft
    end
  end
end
