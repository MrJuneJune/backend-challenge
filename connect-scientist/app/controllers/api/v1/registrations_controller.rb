class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    @user = User.new(user_params)
    @user.profile = Profile.new(profile_params)

    if @user.save 
      render json: @user
    else
      # TODO: Add better errors
      render json: { error: 'signup error' }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find_by_email(user_params[:email])
    if @user.destroy
      render :json=> { success: 'user was successfully deleted' }, :status=>201
    else
      render :json=> { error: 'user could not be deleted' }, :status=>422
    end
  end

  private

  def user_params
     params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:profile).permit(:name, :long_website_url)
  end
end
