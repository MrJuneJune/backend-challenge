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
    long_website_url { Faker::Internet.url }
    short_website_url { Faker::Internet.url }
  end
end
