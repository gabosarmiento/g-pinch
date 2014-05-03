class PhotoPolicy < ApplicationPolicy
  def index?
    true
  end 
  def show? 
    update?
  end

  def update?
    user.present? && (record.portfolio.user == user || user.role?(:admin) || user.is_his_job?(record.portfolio))
  end


end