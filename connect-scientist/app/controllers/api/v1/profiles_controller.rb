class Api::V1::ProfilesController < Api::V1::BaseController
  include SearchThroughFriends
  def index
    profiles = Profile.includes(:friendship_profiles).all
    if profiles
      render json: profiles,
             status: :ok,
             each_serializer: ProfilesSerializer
    else
      respond_404_with_error_message("There are no profiles")
    end
  end

  def show
    if current_profile
      render json: current_profile,
             status: :ok
    else
      respond_404_with_error_message("There are no profile id: #{params[:id]}")
    end
  end

  def find_expert
    recommendations, _ = ask_through_friends(current_profile)

    render json: recommendations,
           status: :ok,
           each_serializer: RecommendedSerializer
  end

  private

  def current_profile
    # includes so no n+1 queries.
    Profile.includes(:friendship_profiles).find_by(id: profile_params[:id])
  end

  def profile_params
    params.permit(:keywords, :id, :profile)
  end
end
