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
class Friendship < ApplicationRecord
  # Association
  # ===========
  # friendship_profile is reference to Profile model so it returns Profile model
  belongs_to :profile
  belongs_to :friendship_profile, class_name: "Profile" 

  # Callbacks
  # ===========
  # One(profile_id) can have multiple friends(friendship_profile_id).
  # Since it is bi-directional, therese should be callback for creating vice-versa
  # one's friends (now profile_id) should have one as a friend(now friendship_profile_id)
  after_create :create_inverse, unless: :has_inverse? # if there is no inverse relationship, create inverse relationship
  after_destroy :destroy_inverses, if: :has_inverse? # destroy if they are no longer friends

  # Validations
  # ===========
  validates_presence_of :friendship_profile_id, :profile_id

  # Methods
  # ===========
  def create_inverse
    self.class.create(inverse_match_options)
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def has_inverse?
    self.class.exists?(inverse_match_options)
  end

  def inverses
    self.class.where(inverse_match_options)
  end
  def inverse_match_options
    { friendship_profile_id: profile_id, profile_id: friendship_profile_id }
  end
end
