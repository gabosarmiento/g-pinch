# == Schema Information
#
# Table name: jobs
#
#  id           :integer          not null, primary key
#  portfolio_id :integer
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Job < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :user
end
