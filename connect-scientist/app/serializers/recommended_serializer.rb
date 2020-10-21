class RecommendedSerializer < ApplicationSerializer
  attributes :id, :name, :short_website_url, :payload, :path, :url

  def url
    Rails.application.routes.url_helpers.api_v1_profile_path(self.object)
  end

  # How it found this person
  def path
    # TODO: Save name?
    self.object.path.map { |id| Profile.find(id).name }.join(", ")
  end
end
