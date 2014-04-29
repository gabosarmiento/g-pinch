class PhotoPolicy < ApplicationPolicy
  def index?
    true
  end 
  def show? 
    record.public? || (record.user == user || user.role?(:admin))
  end

  def create?
    user.present? && (record.user == user || user.role?(:admin))
  end
  
end