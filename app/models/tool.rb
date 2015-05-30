class Tool < ActiveRecord::Base
  has_paper_trail
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :users
  has_many :users, through: :tvotes
  has_many :tvotes
  has_many :reviews
end
