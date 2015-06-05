class CategoriesTools < ActiveRecord::Base
  has_paper_trail
  belongs_to :category
  belongs_to :tool

  validates :category_id, presence: true, numericality: { only_integer: true }
  validates :tool_id, presence: true, numericality: { only_integer: true }
  validates :tool_categories_count, on: :create

  def tool_categories_count
    # console.log("Tool categories count running");
    puts "Tool categories count running"
    tool = Tool.find(tool_id)
    puts "Tool Title: #{tool[:title]}";
    if tool.categories.length >= 3
      errors.add(:tool_id, "can only have 3 categories")
    end
  end

  # validate :active_customer, on: :create

  # def active_customer
  #   errors.add(:customer_id, "is not active") unless customer.active?
  # end




  # create_table "categories_tools", force: :cascade do |t|
  #   t.integer  "category_id"
  #   t.integer  "tool_id"
  #   t.datetime "created_at",  null: false
  #   t.datetime "updated_at",  null: false
  # end

  # add_index "categories_tools", ["category_id"], name: "index_categories_tools_on_category_id", using: :btree
  # add_index "categories_tools", ["tool_id"], name: "index_categories_tools_on_tool_id", using: :btree
end
