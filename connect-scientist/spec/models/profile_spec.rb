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
require 'rails_helper'

RSpec.describe Profile, type: :model do
  # Association test
  it { should belong_to(:user) }
  it { should have_many(:friendships).dependent(:destroy) }
  it { should have_many(:friendship_profiles).dependent(:destroy) }

  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:long_website_url) }

  it "Invalid URL validations" do
    user = build(:user)
    profile = build(:profile, user: user, long_website_url: "non_url")
    expect(profile).to_not be_valid
  end

  it "Valid URL validations" do
    user = build(:user)
    profile = build(:profile, user: user, long_website_url: "https://youtube.com/")
    expect(profile).to be_valid
  end

  it "Check if heading values are saved and shoretn url to be created" do
    user = build(:user)
    profile = build(:profile, user: user, long_website_url: "https://www.w3schools.com/html/html_headings.asp")
    profile.save
    # TODO: Create a better way to test grabbing heading values.
    puts profile.short_website_url
    expect(profile.payload["h1"]).to_not be_nil
  end

end
