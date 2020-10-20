module Bitly
  extend ActiveSupport::Concern
  def shorten_url profile
    body = {
      "domain": default_domain,  
      "long_url": profile.long_website_url
    }  
    response = execute_post_request(shorten_url_url, body)
    parse_result(response)
  end

  def execute_post_request(url, body)
    request, http = make_post_request(url)
    request['authorization'] = auth_token
    request['Content-Type'] = 'application/json'
    request.body = body.to_json
    http.request(request)
  end

  def parse_result(response)
   if JSON.parse(response.read_body)["link"]
     JSON.parse(response.read_body)["link"]
   else
     raise Exception.new "There was a problem creating shorten url"
   end
  end

  def make_post_request url
    url = URI(url)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    [request, http]
  end

  # TODO: Save these and env variables
  # TODO: create a method for creating auth token since it expires every few days
  def auth_token
    "c3b5393dee73df6bbd5be40ba4487b433ea9603f"
  end

  def shorten_url_url 
    "https://api-ssl.bitly.com/v4/shorten"
  end

  def default_domain
    "bit.ly"
  end
end
