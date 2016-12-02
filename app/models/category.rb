class Category < ApplicationRecord
  has_many :work_categories
  has_many :works, through: :work_categories
  has_many :freelancer_categories
  has_many :users, through: :freelancer_categories
end
