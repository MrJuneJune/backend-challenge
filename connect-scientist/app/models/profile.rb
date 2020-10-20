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
  # Concerns
  # ===========
  include Bitly
  include Webscrapper

  # Association
  # ===========
  # It has multiple friendships and it is going to use friendships's friendship_profile_id(friends) to return Profile records.
  belongs_to :user
  has_many :friendships, dependent: :destroy
  has_many :friendship_profiles, through: :friendships, dependent: :destroy

  # Validations
  # ===========
  validates_presence_of :name, :long_website_url
  validates :long_website_url, format: URI::regexp(%w[http https])

  # Callbacks
  # ===========
  before_save :grab_headings_data
  before_save :create_shorten_url

  # Methods
  # ===========
  def not_friends
    # No need to grab both friendship and user since it will be duplicated.
    Friendship.where.not(user_id: self.id, friendship_user_id: self.id).map(&:user)
  end

  private

  def grab_headings_data
    self.payload = self.grab_url_data(self)
  end

  def create_shorten_url
    self.short_website_url = self.shorten_url(self)
  end
end
