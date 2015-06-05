class TagsTools < ActiveRecord::Base
  has_paper_trail
  belongs_to :tag
  belongs_to :tool

  validates :tag_id, presence: true, numericality: { only_integer: true }
  validates :tool_id, presence: true, numericality: { only_integer: true }
  validates_uniqueness_of :tag_id, :scope => :tool_id

  # create_table "tags_tools", force: :cascade do |t|
  #   t.integer  "tag_id"
  #   t.integer  "tool_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

  # add_index "tags_tools", ["tag_id"], name: "index_tags_tools_on_tag_id", using: :btree
  # add_index "tags_tools", ["tool_id"], name: "index_tags_tools_on_tool_id", using: :btree

end
