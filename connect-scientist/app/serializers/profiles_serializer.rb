class ProfilesSerializer < ApplicationSerializer
  attributes :id, :name, :short_website_url, :num_friends

  def num_friends
    self.object.friendship_profiles.length
  end
end
