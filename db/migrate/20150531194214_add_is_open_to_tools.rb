class AddIsOpenToTools < ActiveRecord::Migration
  def change
    add_column :tools, :is_open, :boolean
  end
end
