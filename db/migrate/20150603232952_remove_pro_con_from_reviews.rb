class RemoveProConFromReviews < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.remove :con
      t.rename :pro, :post
    end
  end
end
