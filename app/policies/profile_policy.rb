class ProfilePolicy < ApplicationPolicy

  def index?
    true
  end
  def show?
    user.present? && (record.state?(:approved) || user.role?(:admin))
  end
  def update?
    user.present? && record.user == user && user.role?(:pro) || user.role?(:admin)
  end

end