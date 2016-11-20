class Joiner < ApplicationRecord
  belongs_to :user
  belongs_to :work
  has_one review_freelancer
end
