class ModelCourse < ApplicationRecord
  belongs_to :application_user
  has_many :course_spots, dependent: :destroy
  has_many :spots, through: :course_spots
  has_many :favorites, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :access_keys, dependent: :destroy

  has_many :model_course_images, dependent: :destroy
  accepts_nested_attributes_for :model_course_images, allow_destroy: true

  validates :title, presence: true

  # モデルコース作成時に公開キーを自動生成
  before_create :generate_public_key
  private
  def generate_public_key
    self.public_key = "user#{application_user_id}-course#{id}-#{SecureRandom.hex(8)}"
  end

end
