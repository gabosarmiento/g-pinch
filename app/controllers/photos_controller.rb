class PhotosController < ApplicationController
  def index
    @portfolio = Portfolio.find(params[:portfolio_id])
    @photos = @portfolio.photos
  end

  def show
     @photo = Photo.find(params[:id])
     authorize @photo 
  end

  def new
    @portfolio = Portfolio.find(params[:portfolio_id])
    @photo = @portfolio.photos.build
    @photos = @portfolio.photos
  end

  def edit
    @photo = Photo.find(params[:id])
    authorize @photo
  end

  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @photo = @portfolio.photos.create(photo_params)
    authorize @photo
    # if @photo.save
    # flash[:success] = 'Your photo was saved'
    # redirect_to [@portfolio, @photo]
    # else
    # flash[:error] = "Error saving photo. Please try again."
    # render :new
    # end 
  end

  def destroy
    @photo = Photo.find(params[:id])
    @portfolio = @photo.portfolio
    @photos = @portfolio.photos
    authorize @photo
    if @photo.destroy
      respond_to do |format|
        format.js
      end
    end
  end

  private 
  def photo_params 
    params.require(:photo).permit(:title, :description, :image, :adult, :exif, :category, :portfolio_id)
  end
end
