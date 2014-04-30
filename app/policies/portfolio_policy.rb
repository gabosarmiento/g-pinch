class PortfolioPolicy < ApplicationPolicy

  def index? 
    true
  end 
  def show? 
    record.public? || (record.user == user || user.role?(:admin) || user.is_his_job?(record)) 
  end

  def gallery?
   true
  end

end