class Work < ApplicationRecord
  belongs_to :user
  has_many :work_categories
end
