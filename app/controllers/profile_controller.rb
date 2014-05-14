class ProfileController < ApplicationController
  def index
    @profiles = Profile.all.approved
    authorize @profiles
  end

  def create
    @profile = current_user.create_profile
    authorize @profile 
    if @profile.save
      redirect_to @profile, notice: "Profile created successfully"
    else
      flash[:error] = "Error creating Profile. Please try again."
      redirect_to edit_user_registration_path
    end
  end  
  def show
    @profile = Profile.find(params[:id])
    authorize @profile 
    @user = @profile.user
    @portfolios = current_user.portfolios
    @judges = User.where(:role => "judge")
    @price = User::PRICE
    @job = Job.new
  end

  def edit
    @profile = current_user.profile
    authorize @profile 
  end

  def update
    @profile = current_user.profile
    authorize @profile 
    if @profile.update_attributes(profile_params)
      redirect_to @profile
    end
  end

  def destroy
  end

  private
  def profile_params
    params.require(:profile).permit(:country, :website, :header, :pic, :separator, :footer, :bio, :experience, :title)
  end
end
