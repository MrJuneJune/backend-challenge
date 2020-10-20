class AddUserRelationshipToProfile < ActiveRecord::Migration[6.0]
  def change
    add_reference :profiles, :user, index: true
  end
end
