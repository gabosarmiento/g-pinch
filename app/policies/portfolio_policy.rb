class PortfolioPolicy < ApplicationPolicy

  def index? 
    true
  end 
  def show? 
    record.public? && (record.user == user || user.role?(:admin)) 
  end

  def gallery?
   false
  end

end