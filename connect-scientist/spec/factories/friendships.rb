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
FactoryBot.define do
  factory :friendships do
  end
end
