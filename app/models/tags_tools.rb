class TagsTools < ActiveRecord::Base
  has_paper_trail
  belongs_to :tag
  belongs_to :tool
end
