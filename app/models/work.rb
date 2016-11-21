class Work < ApplicationRecord
  belongs_to :user
<<<<<<< HEAD
=======
  has_many :work_categories
  has_many :categories, through: :work_categories
  has_many :joiners
  has_many :users, through: :joiners
  has_one :review_category
>>>>>>> 03daf97c98930b6552003010aeea46a1483c0f21
end
