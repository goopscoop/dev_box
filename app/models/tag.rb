class Tag < ActiveRecord::Base
  has_and_belongs_to_many :tools

  validates :tag, presence: true, uniqueness: true

  # create_table "tags", force: :cascade do |t|
  #   t.string   "tag"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

end
