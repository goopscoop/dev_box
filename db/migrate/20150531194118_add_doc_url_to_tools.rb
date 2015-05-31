class AddDocUrlToTools < ActiveRecord::Migration
  def change
    add_column :tools, :doc_url, :string
  end
end
