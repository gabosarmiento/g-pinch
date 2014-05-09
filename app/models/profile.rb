# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  state      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  country    :string(255)
#  website    :string(255)
#  header     :string(255)
#  pic        :string(255)
#  separator  :string(255)
#  footer     :string(255)
#  bio        :text
#  experience :text
#  title      :string(255)
#

class Profile < ActiveRecord::Base
  belongs_to :user
  mount_uploader :pic, PicUploader
  mount_uploader :header, HeaderUploader
  mount_uploader :separator, SeparatorUploader
  mount_uploader :footer, FooterUploader
  scope :approved, -> {with_state(:approved)}
  state_machine initial: :incomplete do 
    event :verification do 
      transition :incomplete => :open
    end 

    event :reject do 
      transition :open => :rejected
    end

    event :resume do
      transition :rejected => :open
    end

    event :accept do
      transition :open => :approved
    end

    before_transition :open => :approved do |profile|
      self.user.update_attribute(:role, "judge")
    end
  end
end
