# == Schema Information
#
# Table name: sales
#
#  id         :integer          not null, primary key
#  job_id     :integer
#  email      :string(255)
#  guid       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Sale < ActiveRecord::Base
  belongs_to :job
  before_create :populate_guid
  private
  def populate_guid
    self.guid = SecureRandom.uuid()
  end
end
