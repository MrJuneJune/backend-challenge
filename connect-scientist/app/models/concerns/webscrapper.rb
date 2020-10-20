module Webscrapper
  extend ActiveSupport::Concern
  def grab_url_data profile
    begin
      uri = URI.open(profile.long_website_url)
      get_headings_from_uri(uri)
    rescue
      raise Exception.new "There was a problem getting header info"
    end
  end

  def get_headings_from_uri uri
    doc = Nokogiri::HTML(uri)  
    headings_data = {}
    interestd_tags.each do |tag|
     headings_data[tag] = []
     doc.css(tag).each do |link|
       headings_data[tag].append(link.content.gsub(/\s+/, ""))
     end
    end
    headings_data
  end

  def interestd_tags
    ['h1', 'h2', 'h3']
  end
end
