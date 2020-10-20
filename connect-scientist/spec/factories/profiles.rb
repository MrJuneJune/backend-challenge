# == Schema Information
#
# Table name: profiles
#
#  id                :bigint           not null, primary key
#  name              :string
#  long_website_url  :string
#  short_website_url :string
#  payload           :json
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint
#
FactoryBot.define do
  factory :profile do
    # TODO: short website should be something else
    name { Faker::Name.name }
    long_website_url { "https://www.w3schools.com/html/html_headings.asp" }
  end
end
