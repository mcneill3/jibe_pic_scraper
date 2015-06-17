class CreateInstaAccounts < ActiveRecord::Migration
  def change
    create_table :insta_accounts do |t|
      t.string :access_token
      t.string :username

      t.timestamps null: false
    end
  end
end
