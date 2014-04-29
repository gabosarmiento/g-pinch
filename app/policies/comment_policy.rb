class CommentPolicy < ApplicationPolicy
  def destroy?
    user.present? && (record.user == user || user.role?(:admin) || user.role?(:curator))
  end
end