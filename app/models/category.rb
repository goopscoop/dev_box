class Category < ActiveRecord::Base
  has_and_belongs_to_many :tools

  # create_table "categories", force: :cascade do |t|
  #   t.string   "category"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

end
