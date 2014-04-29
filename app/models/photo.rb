# == Schema Information
#
# Table name: photos
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :string(255)
#  image        :string(255)
#  portfolio_id :integer
#  position     :integer
#  adult        :boolean
#  exif         :string(255)
#  category     :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Photo < ActiveRecord::Base
  belongs_to :portfolio
  has_many :comments, as: :commentable
end
