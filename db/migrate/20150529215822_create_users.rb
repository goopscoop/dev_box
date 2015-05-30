class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :image_url
      t.string :provider
      t.string :provider_id
      t.string :provider_hash
      t.string :refresh_hash
      t.datetime :hash_expires_at

      t.timestamps null: false
    end
  end
end
