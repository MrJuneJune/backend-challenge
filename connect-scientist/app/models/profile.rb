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
class Profile < ApplicationRecord
  # Association
  # ===========
  # It has multiple friendships and it is going to use friendships's friendship_profile_id(friends) to return Profile records.
  belongs_to :user
  has_many :friendships, dependent: :destroy
  has_many :friendship_profiles, through: :friendships, dependent: :destroy

  # Validations
  # ===========
  validates_presence_of :name, :long_website_url
end
