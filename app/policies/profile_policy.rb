class ProfilePolicy < ApplicationPolicy

  def index?
    true
  end
  def show?
    user.present? && (record.user == user || record.state?(:approved) || user.role?(:admin))
  end

end