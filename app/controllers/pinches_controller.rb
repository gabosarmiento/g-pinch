class PinchesController < ApplicationController
  def create
    @job = Job.find.params[:job_id]
    @pinch = @job.pinches.create(pinches_params)
  end

  def destroy
  end
  private
  def pinches_params
    paramos.require(:pinch).permit(:opinion, :pinch, :job_id, :photo_id)
    
  end
end
