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
  it { should have_many(:friendship_users).dependent(:destroy) }

  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:long_website_url) }

end
