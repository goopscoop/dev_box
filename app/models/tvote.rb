class Tvote < ActiveRecord::Base
  belongs_to :tool
  belongs_to :user

  validates :vote, presence: true, numericality: { only_integer: true, equal_to: 1 }
  validates :tool_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates_uniqueness_of :user_id, :scope => :tool_id

  # create_table "tvotes", force: :cascade do |t|
  #   t.integer  "vote"
  #   t.integer  "tool_id"
  #   t.integer  "user_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

  # add_index "tvotes", ["tool_id"], name: "index_tvotes_on_tool_id", using: :btree
  # add_index "tvotes", ["user_id"], name: "index_tvotes_on_user_id", using: :btree

end
