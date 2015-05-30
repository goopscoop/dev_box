class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :pro
      t.text :con
      t.integer :rating
      t.references :tool, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
