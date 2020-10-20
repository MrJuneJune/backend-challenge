class Api::V1::ProfilesController < Api::V1::BaseController
  def index
    profiles = Profile.all
    if profiles
      render json: profiles,
             status: :ok,
             each_serializer: ProfilesSerializer
    else
      respond_404_with_error_message("There are no profiles")
    end
  end

  def show
    if profile
      render json: profile,
             status: :ok
    else
      respond_404_with_error_message("There are no profile id: #{params[:id]}")
    end
  end

  private

  def profile
    profile = Profile.find_by(id: params[:id])
  end

  def expert_params
    params.permit(:keywords)
  end
end
