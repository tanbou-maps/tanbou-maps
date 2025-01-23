class ModelCourse < ApplicationRecord
  belongs_to :application_user
  has_many :course_spots, dependent: :destroy
  has_many :spots, through: :course_spots
  has_many :favorites, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :access_keys, dependent: :destroy

  # Active Storage
  has_one_attached :theme_image
  has_many_attached :gallery_images

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }

   # 公開キー生成
   before_validation :generate_public_key, on: :create


  # 画像URLを取得するメソッド
  def theme_image_url
    theme_image.attached? ? Rails.application.routes.url_helpers.url_for(theme_image) : nil
  rescue ArgumentError, ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  def gallery_image_urls
    gallery_images.map { |image| Rails.application.routes.url_helpers.url_for(image) }
  end

  private
  def generate_public_key
    self.public_key ||= "user#{application_user_id}-course#{SecureRandom.hex(8)}"
  end
end
