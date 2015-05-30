class CreateCategoriesTools < ActiveRecord::Migration
  def change
    create_table :categories_tools do |t|
      t.references :category, index: true, foreign_key: true
      t.references :tool, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
