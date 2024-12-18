# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :application_user
  belongs_to :spot
  has_many_attached :images

  # バリデーション
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :rating, presence: true,
                     numericality: {
                       only_integer: true,
                       greater_than_or_equal_to: 1,
                       less_than_or_equal_to: 5
                     }
  validates :images, presence: true
  validate :validate_images

  private

  def validate_images
    return unless images.attached?

    images.each do |image|
      errors.add(:images, 'はJPEGまたはPNG形式でアップロードしてください') unless image.content_type.in?(%w[image/jpeg image/png])

      errors.add(:images, 'は1枚あたり5MB以下のサイズにしてください') if image.blob.byte_size > 5.megabytes
    end

    return unless images.length > 5

    errors.add(:images, 'は5枚までしかアップロードできません')
  end
end
