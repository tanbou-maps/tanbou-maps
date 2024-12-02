class ModelCourse < ApplicationRecord
  belongs_to :application_user
  has_many :course_spots, dependent: :destroy
  has_many :spots, through: :course_spots
  has_many :favorites, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :access_keys, dependent: :destroy

  has_many :model_course_images, dependent: :destroy
  accepts_nested_attributes_for :model_course_images, allow_destroy: true

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :theme_image_url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true }

  # モデルコース作成時に公開キーを自動生成
  after_create :generate_public_key
  private
  def generate_public_key
    self.public_key = "user#{application_user_id}-course#{id}-#{SecureRandom.hex(8)}"
  end

end
