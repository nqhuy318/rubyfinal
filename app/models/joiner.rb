class Joiner < ApplicationRecord
  belongs_to :user
  belongs_to :work
  has_many :categories, through: :work, through: :user
  has_many :review_freelancer
end
