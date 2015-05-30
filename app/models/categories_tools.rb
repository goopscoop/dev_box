class CategoriesTools < ActiveRecord::Base
  belongs_to :category
  belongs_to :tool
end
