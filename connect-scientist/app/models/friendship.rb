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
  # association
  belongs_to :user # friend belong to user_id
  belongs_to :friendship_profile, class_name: "User" # friend belong to multiple frinedship_profile_id

  # callbacks
  after_create :create_inverse, unless: :has_inverse?
  after_destroy :destroy_inverses, if: :has_inverse?

  # validations

  # methods
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
    { friendship_user_id: user_id, user_id: friendship_user_id }
  end
end
