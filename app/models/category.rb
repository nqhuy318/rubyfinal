class Category < ApplicationRecord
  has_many :work_categories
  has_many :freelancer_categories
end
