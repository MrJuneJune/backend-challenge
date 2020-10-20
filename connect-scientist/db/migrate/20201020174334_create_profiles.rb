class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :long_website_url
      t.string :short_website_url
      t.json 'payload'
      t.timestamps
    end
  end
end
