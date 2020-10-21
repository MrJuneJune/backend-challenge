class RecommendedSerializer < ApplicationSerializer
  attributes :id, :name, :short_website_url, :payload, :path, :url

  def url
    Rails.application.routes.url_helpers.api_v1_profile_path(self.object)
  end
end
