# == Schema Information
#
# Table name: pinches
#
#  id         :integer          not null, primary key
#  note       :string(255)
#  x          :float
#  y          :float
#  position   :integer
#  job_id     :integer
#  photo_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Pinch < ActiveRecord::Base
  belongs_to :job
  belongs_to :photo
  acts_as_list scope: :job 
end
