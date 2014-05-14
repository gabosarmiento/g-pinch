class JobPolicy < ApplicationPolicy
  def index? 
    true
  end

  def review?
    user.present? && (user.is_his_job?(record.portfolio) ||  user.role?(:admin))
  end
end