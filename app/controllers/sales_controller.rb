class SalesController < ApplicationController
  def index
    @sales = Sale.all
    @sale_validation = Sale.new
    authorize @sale_validation
  end
  def show
    @sale = Sale.find(params[:id])
    authorize @sale
  end
end
