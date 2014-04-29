class Portfolio < ActiveRecord::Base
  has_many :photos, dependent: :destroy
  has_many :jobs
  belongs_to :user
  scope :visible_to, ->(user) { user ? all : where(public: true) }
end
