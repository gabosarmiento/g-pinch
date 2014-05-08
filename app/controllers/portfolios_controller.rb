class PortfoliosController < ApplicationController
  respond_to :html, :js 
  def index
    @portfolios = current_user.portfolios
    @portfolio = Portfolio.new
    @commissioned = current_user.portfolios.under_revision
    @photos = Photo.new
    authorize @portfolio
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    @photos = @portfolio.photos
    @photo = Photo.new
    authorize @portfolio
    respond_to do |format|
      format.js
      format.html 
    end
  end

  def new
  end

  def edit
  end

  def create
    @portfolios = current_user.portfolios
    @portfolio = current_user.portfolios.create(portfolio_params)
    @new_portfolio = current_user.portfolios.new
    @photos = @portfolio.photos
    @photo = Photo.new
    authorize @portfolio
  end

  def update
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    name = @portfolio.name
    authorize @portfolio
    if @portfolio.destroy
      respond_to  do |format|
        format.html { redirect_to portfolios_path, notice: "\"#{name}\" was deleted successfully."}
        format.js
      end
    end
  end

  def gallery
    @portfolios = Portfolio.visible.paginate(page: params[:page], per_page: 10)
    @validation_portfolio = current_user.portfolios.new
    authorize @validation_portfolio
  end

  private 
  def portfolio_params 
    params.require(:portfolio).permit(:name, :needs, :public, photos_attributes: [:title, :description, :image, :adult, :exif, :category, :portfolio_id] )
  end
end
