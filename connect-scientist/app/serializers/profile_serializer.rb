class ProfileSerializer < ApplicationSerializer
  attributes :id, :name, :long_website_url, :short_website_url, :payload, :friends

  def friends
    self.object.friendship_profiles.map { |friend| {"name": friend.name, "url": get_user_url(friend)}}
  end

  def get_profile_url profile
    Rails.application.routes.url_helpers.api_v1_profile_path(profile)
  end
end
