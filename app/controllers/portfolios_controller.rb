class PortfoliosController < ApplicationController
  respond_to :html, :js 
  def index
    @portfolios = current_user.portfolios
    @portfolio = current_user.portfolios.new
    authorize @portfolio
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @portfolios = current_user.portfolios
    @portfolio = current_user.portfolios.new(portfolio_params)
    @new_portfolio = current_user.portfolios.new
    authorize @portfolio
    if @portfolio.save
      respond_with(@portfolio) do |format|
        format.html { redirect_to portfolios_path}
      end
    end
  end

  def update
  end

  def destroy
  end

  private 
  def portfolio_params 
    params.require(:portfolio).permit(:name, :needs, :public )
  end
end
