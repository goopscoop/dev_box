class TagsTools < ActiveRecord::Base
  belongs_to :tag
  belongs_to :tool
end
