class Work < ApplicationRecord
  belongs_to :user

  has_many :work_categories
  has_many :categories, through: :work_categories
#  accepts_nested_attributes_for :work_categories
  has_many :joiners
  has_many :users, through: :joiners
  has_one :review_category

end
