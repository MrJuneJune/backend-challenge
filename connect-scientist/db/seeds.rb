# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#
require 'factory_bot'
require 'faker'
#require_relative "../spec/rails_helper/users"
require_relative "../spec/factories/users"
require_relative "../spec/factories/profiles"
require_relative "../spec/factories/friendships"

9.times do |i|
  u = FactoryBot.create(:user, email: "test#{i}@gmail.com")
  p = FactoryBot.create(:profile, user: u)

  if i > 2
    p.friendship_profiles << Profile.second_to_last
  end
end

