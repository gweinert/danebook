class ProfilesController < ApplicationController

  def index
    user = User.find(params[:user_id])
    @profile = user.profile
  end

  def edit
    @profile = current_user.profile
  end

  def update
    if current_user.profile.update(profile_params)
      #check if valid!
      current_user.email = params[:user][:email]
      current_user.save
      flash[:notice] ="Profile updated successfully!"
      redirect_to user_profiles_path(current_user)
    else
      flash.now[:error] = "Profile failed to update"
      render :edit
    end
  end


  private

    def profile_params
      params.require(:profile).permit(:college_name, :hometown, :current_home, :telephone, :words_to_live_by, :about_me)
    end
end