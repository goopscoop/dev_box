class CreateCollectionsUsers < ActiveRecord::Migration
  def change
    create_table :collections_users do |t|
      t.references :collection, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
