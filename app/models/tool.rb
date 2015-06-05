class Tool < ActiveRecord::Base
  has_paper_trail
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :users
  has_many :tvotes
  has_many :reviews

  validates :title, presence: true
  validates :description, presence: true

  # create_table "tools", force: :cascade do |t|
  #   t.string   "title"
  #   t.text     "description"
  #   t.string   "language"
  #   t.integer  "is_free"
  #   t.string   "web_url"
  #   t.string   "repo_url"
  #   t.integer  "avg_rating"
  #   t.datetime "created_at",  null: false
  #   t.datetime "updated_at",  null: false
  #   t.string   "doc_url"
  #   t.boolean  "is_open"
  # end

end
