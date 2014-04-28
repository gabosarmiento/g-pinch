class Portfolio < ActiveRecord::Base
  has_many :photos
  scope :visible_to, ->(user) { user ? all : where(public: true) }
end
