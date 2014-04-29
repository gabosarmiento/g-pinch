class ProfilePolicy < ApplicationPolicy

  def index?
    true
  end

  def update?
    user.present? && record.user == user && user.role?(:pro) || user.role?(:admin)
  end

end