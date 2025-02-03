class Spot < ApplicationRecord
  belongs_to :application_user, optional: true # どのユーザーが作成したスポットなのかを紐づける
  has_many_attached :photos # active_storage を使用してスポットに対する写真をデータベースに追加できるようにしている
  has_one :spot_detail, dependent: :destroy
  has_many :categories_spots, dependent: :destroy
  has_many :categories, through: :categories_spots
  has_many :events, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :spot_tags, dependent: :destroy
  has_many :stamps, dependent: :destroy
  has_many :course_spots, dependent: :destroy
  has_many :model_courses, through: :course_spots

  validates :name, presence: true
  validates :description, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  accepts_nested_attributes_for :spot_detail
  accepts_nested_attributes_for :spot_tags, allow_destroy: true
end
