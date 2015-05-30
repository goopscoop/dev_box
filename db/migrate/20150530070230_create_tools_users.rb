class CreateToolsUsers < ActiveRecord::Migration
  def change
    create_table :tools_users do |t|
      t.references :tool, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
