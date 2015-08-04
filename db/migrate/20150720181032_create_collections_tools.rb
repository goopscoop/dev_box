class CreateCollectionsTools < ActiveRecord::Migration
  def change
    create_table :collections_tools do |t|
      t.references :collection, index: true, foreign_key: true
      t.references :tool, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
