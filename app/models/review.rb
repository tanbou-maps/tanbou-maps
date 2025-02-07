class Review < ApplicationRecord
  belongs_to :spot
  belongs_to :application_user

  # ActiveStorageの設定を追加
  has_many_attached :images

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true, length: { maximum: 1000 }

  # app/models/review.rb
  def images_urls
    images.map do |image|
      {
        id: image.id,
        url: Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
      }
    end
  end
end
