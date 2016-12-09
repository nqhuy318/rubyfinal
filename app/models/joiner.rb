class Joiner < ApplicationRecord
  belongs_to :user
  belongs_to :work
  has_many :categories, through: :work, through: :user
  has_one :review_freelancer
end
