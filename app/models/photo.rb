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

require 'file_size_validator'
class Photo < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :portfolio
  has_many :comments, as: :commentable
  has_many :pinches
  #before create assign a name
  before_create :default_name
  validates :portfolio, presence: true
  validates :image, 
    :presence => true, 
    :file_size => { 
      :maximum => 5.0.megabytes.to_i
    } 

  def default_name
  self.title ||= File.basename(image.filename, '.*').titleize if image
  end
  
end
