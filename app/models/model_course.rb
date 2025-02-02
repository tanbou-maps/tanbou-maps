class ModelCourse < ApplicationRecord
  belongs_to :application_user
  has_many :course_spots, dependent: :destroy
  has_many :spots, through: :course_spots
  # has_many :favorites, dependent: :destroy
  # has_many :likes, dependent: :destroy
  # has_many :access_keys, dependent: :destroy

  # Active Storage
  has_one_attached :theme_image#, dependent: :destroy
  has_many_attached :gallery_images

  before_create :assign_record_uuid

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :budget, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :season, presence: true
  validates :genre_tags, length: { maximum: 255 }

  # 公開キー生成
  before_validation :generate_public_key, on: :create

  # カンマ区切りのタグを配列化
  def genre_tags_array
    genre_tags.present? ? genre_tags.split(",").map(&:strip) : []
  end

  # **修正: UUID を自動生成**
  private

  def assign_record_uuid
    self.record_uuid ||= SecureRandom.uuid
  end

  def generate_public_key
    self.public_key ||= "user#{application_user_id}-course#{SecureRandom.hex(8)}"
  end

  # **修正: ActiveStorage の record_id は bigint（id）を使う**
  def theme_image_url
    if theme_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(theme_image, only_path: true)
    else
      nil
    end
  end
end
