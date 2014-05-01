class SalePolicy < ApplicationPolicy
  def index?
    show?
  end
  def show?
    user.present? && user.role?(:admin)
  end
end