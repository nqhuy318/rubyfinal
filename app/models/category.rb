class Category < ApplicationRecord
<<<<<<< HEAD
=======
  has_many :work_categories
  has_many :works, through: :work_categories
  has_many :freelancer_categories
  has_many :users, through: :freelancer_categories
>>>>>>> 03daf97c98930b6552003010aeea46a1483c0f21
end
