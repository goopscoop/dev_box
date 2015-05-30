class AddAvgRatingToTools < ActiveRecord::Migration
  def change
    add_column :tools, :avg_rating, :integer
  end
end
