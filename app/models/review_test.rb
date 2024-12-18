class ReviewTest < ApplicationRecord
  validates :title, presence: true
  validates :memo, presence: true, length: { minimum: 5 }
end
