class Portfolio < ActiveRecord::Base
  has_many :photos, dependent: :destroy
  has_many :jobs
  scope :visible_to, ->(user) { user ? all : where(public: true) }
end
