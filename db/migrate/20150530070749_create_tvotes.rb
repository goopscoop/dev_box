class CreateTvotes < ActiveRecord::Migration
  def change
    create_table :tvotes do |t|
      t.integer :vote
      t.references :tool, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
