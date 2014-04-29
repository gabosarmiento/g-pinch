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
#

class Portfolio < ActiveRecord::Base
  has_many :photos, dependent: :destroy
  has_many :jobs
  belongs_to :user
  scope :visible_to, ->(user) { user ? all : where(public: true) }

end
