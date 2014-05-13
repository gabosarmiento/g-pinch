class PinchesController < ApplicationController
  def create
    @job = Job.find(params[:job_id])
    @photo = Photo.find(params[:photo_id])
    @pinch = @job.pinches.find_or_create_by!(pinches_params)
    @pinch.photo = @photo 
    @pinch.save
    @pinches = @photo.pinches
    respond_to do |format|
      format.js 
    end
  end

  def destroy
    @job = Job.find(params[:job_id])
    @pinch = Pinch.find(params[:id])
    if @pinch.destroy
      respond_to do |format|
        format.js
      end
    end
  end
  private
  def pinches_params
    params.require(:pinch).permit(:x, :y, :note)
  end
end
