class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :title
      t.text :description
      t.string :language
      t.integer :is_free
      t.string :web_url
      t.string :repo_url

      t.timestamps null: false
    end
  end
end
