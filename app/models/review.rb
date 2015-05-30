class Review < ActiveRecord::Base
  belongs_to :tool
  belongs_to :user
end
