class PortfolioPolicy < ApplicationPolicy

  def index? 
    true
  end 
  def show? 
    record.public? || (record.user == user || user.role?(:admin)) || user.jobs.is_his_job?(record)
  end

end