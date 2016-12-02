class ReviewFreelancer < ApplicationRecord
  belongs_to :work
  belongs_to :joiner
end
