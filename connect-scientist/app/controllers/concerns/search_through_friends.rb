module SearchThroughFriends
  extend ActiveSupport::Concern
  def ask_through_friends profile, recommendations = [], already_asked = [], path=[]
    # If there is no uniq friends left return recommendations and profiles that has already been checked
    # when checking profiles already asked + users in path should be excluded. Uniq since it can be double counted.
    return recommendations, already_asked if !profile.friendship_profiles.where.not(id: (already_asked+path).uniq)

    # If path is empty, then friends are current profile's friends so shouldn't be recommended
    if path.empty? 
      path.append(profile.id) # Added curent use as path
      already_asked += profile.friendship_profiles.pluck(:id) # Don't check all of current profile friends
      # Check friends friend
      profile.friendship_profiles.each do |friend|
        recommendations, already_asked = ask_through_friends(friend, recommendations, already_asked, Array.new(path))
      end
    end
   
    # If path is not empty then it is friend's friends
    #
    # Added the current friend into path
    path.append(profile.id)

    # includes so no n+1 queries.
    profile.friendship_profiles.includes(:friendship_profiles).where.not(id: (already_asked+path).uniq).each do |friend|
      already_asked.append(friend.id)
      if check_keyword(friend) # If friend has keywords
        # Add the path as attributes which will be used in serializer
        friend.path = path
        recommendations.append(friend) # append to recommendations
      end

      # Check for friend's friend's friend's.....
      recommendations, already_asked = ask_through_friends(friend, recommendations, already_asked, Array.new(path))
    end

    return recommendations, already_asked
  end

  def check_keyword profile
    return nil if profile.payload.nil?
    profile.payload.values&.flatten&.first&.include?(profile_params[:keywords])
  end
end
