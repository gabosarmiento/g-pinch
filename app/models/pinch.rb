# == Schema Information
#
# Table name: pinches
#
#  id         :integer          not null, primary key
#  opinion    :text
#  pinch      :string(255)
#  position   :integer
#  job_id     :integer
#  photo_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Pinch < ActiveRecord::Base
  belongs_to :job
  belongs_to :photo
end
