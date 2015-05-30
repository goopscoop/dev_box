class User < ActiveRecord::Base
  has_many :tvotes
  has_many :reviews
  has_and_belongs_to_many :tools
  has_many :tools, through: :tvotes
  # has_many :votes, through: :tvotes,
end
