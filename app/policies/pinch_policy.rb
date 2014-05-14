class PinchPolicy < ApplicationPolicy
  def create
    user.present? && (user.role?(:judge) || user.role?(:admin))
  end
  def destroy
    create?
  end
end