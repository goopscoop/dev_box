class Tvote < ActiveRecord::Base
  belongs_to :tool
  belongs_to :user
end
