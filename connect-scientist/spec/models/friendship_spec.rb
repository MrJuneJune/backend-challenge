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
  # Association test
  it { should belong_to(:profile) }
  it { should belong_to(:friendship_profile) }
end
