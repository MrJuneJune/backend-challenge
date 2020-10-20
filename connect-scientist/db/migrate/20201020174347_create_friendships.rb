class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :profile, index: true, foreign_key: true
      t.references :friendship_profile, index: true

      t.timestamps
    end

    add_foreign_key :friendships, :profiles, column: :friendship_profile_id
    add_index :friendships, [:profile_id, :friendship_profile_id], unique: true
  end
end
