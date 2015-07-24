class User < ActiveRecord::Base
  has_many :tvotes
  has_many :reviews
  has_and_belongs_to_many :tools
  has_and_belongs_to_many :collections

  # create_table "users", force: :cascade do |t|
  #   t.string   "name"
  #   t.string   "email"
  #   t.string   "image_url"
  #   t.string   "provider"
  #   t.string   "provider_id"
  #   t.string   "provider_hash"
  #   t.string   "refresh_hash"
  #   t.datetime "hash_expires_at"
  #   t.datetime "created_at",      null: false
  #   t.datetime "updated_at",      null: false
  #   t.string   "role"
  # end

end
