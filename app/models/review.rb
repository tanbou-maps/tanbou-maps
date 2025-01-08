# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :spot
  belongs_to :application_user

  # ActiveStorageの設定を追加
  has_many_attached :images

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
end
