class ReviewFreelancer < ApplicationRecord
  belongs_to :joiner
  belongs_to :work
end
