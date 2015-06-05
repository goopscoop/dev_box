class ToolsUsers < ActiveRecord::Base
  belongs_to :tool
  belongs_to :user

  validates :tool_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates_uniqueness_of :user_id, :scope => :tool_id

  # create_table "tools_users", force: :cascade do |t|
  #   t.integer  "tool_id"
  #   t.integer  "user_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

  # add_index "tools_users", ["tool_id"], name: "index_tools_users_on_tool_id", using: :btree
  # add_index "tools_users", ["user_id"], name: "index_tools_users_on_user_id", using: :btree

end
