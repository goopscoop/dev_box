class AddToolIdIndexToCategoriesTools < ActiveRecord::Migration
  def up
    remove_index :categories_tools, :tool_id
    remove_index :categories_tools, :category_id
    add_index :categories_tools, :tool_id, unique: true
  end

  def down
    remove_index :categories_tools, :tool_id
  end
end
