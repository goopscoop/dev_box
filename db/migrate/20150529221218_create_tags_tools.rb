class CreateTagsTools < ActiveRecord::Migration
  def change
    create_table :tags_tools do |t|
      t.references :tag, index: true, foreign_key: true
      t.references :tool, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
