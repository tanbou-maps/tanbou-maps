class Review < ApplicationRecord
  belongs_to :spot
  belongs_to :app_user, foreign_key: :user_id
  has_many :review_images
  validates :rating, presence: true, inclusion: { in: 1..5 }
end
