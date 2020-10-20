# == Schema Information
#
# Table name: friendships
#
#  id                    :bigint           not null, primary key
#  profile_id            :bigint
#  friendship_profile_id :bigint
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'rails_helper'

RSpec.describe Friendship, type: :model do
  # Create user and profile
  before(:all) do
    @user = build(:user)
    @user1 = build(:user)
    @profile = create(:profile, user: @user)
    @profile1 = create(:profile, user: @user1)
  end

  # Association test
  it { should belong_to(:profile) }
  it { should belong_to(:friendship_profile) }

  it "Check if bi-directional relationship" do
    @profile.friendship_profiles << @profile1
    expect(@profile.friendship_profiles).to include(@profile1)
    expect(@profile1.friendship_profiles).to include(@profile)
  end

end
