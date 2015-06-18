class CreateFlickrAccounts < ActiveRecord::Migration
  def change
    create_table :flickr_accounts do |t|
      t.string :access_token
      t.string :username

      t.timestamps null: false
    end
  end
end
