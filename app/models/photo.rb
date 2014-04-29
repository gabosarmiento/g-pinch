class Photo < ActiveRecord::Base
  belongs_to :portfolio
  has_many :comments, as: :commentable
end
