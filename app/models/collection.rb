class Collection < ActiveRecord::Base

has_and_belongs_to_many :tools
has_and_belongs_to_many :users

validates :name, presence: true

end
