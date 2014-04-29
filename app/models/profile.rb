# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  state      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Profile < ActiveRecord::Base
  belongs_to :user
end
