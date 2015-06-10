class Review < ActiveRecord::Base
  belongs_to :tool
  belongs_to :user

  validates :tool_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates_uniqueness_of :user_id, :scope => :tool_id

  after_save :set_avg_rating

  protected

    def set_avg_rating
      tool = Tool.find(self.tool_id)
      tool.avg_rating = tool.reviews.average("rating").to_i
      tool.save
    end



  # create_table "reviews", force: :cascade do |t|
  #   t.text     "post"
  #   t.integer  "rating"
  #   t.integer  "tool_id"
  #   t.integer  "user_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

  # add_index "reviews", ["tool_id"], name: "index_reviews_on_tool_id", using: :btree
  # add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

end
