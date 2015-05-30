class CategoriesTools < ActiveRecord::Base
  has_paper_trail
  belongs_to :category
  belongs_to :tool
end
