class PinchesController < ApplicationController
  def create
    @job = Job.find(params[:job_id])
    @photo = Photo.find(params[:photo_id])
    @pinch = @job.pinches.find_or_create_by!(pinches_params)
    @pinch.photo = @photo 
    @pinch.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
  end
  private
  def pinches_params
    params.require(:pinch).permit(:x, :y, :note)
  end
end
