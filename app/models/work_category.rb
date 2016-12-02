class WorkCategory < ApplicationRecord
  belongs_to :work
  belongs_to :category
end
