class Spot < ApplicationRecord
  has_many_attached :photos
  has_one :spot_detail, dependent: :destroy
  has_many :categories_spots
  has_many :categories, through: :categories_spots
  has_many :events, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :spot_tags, dependent: :destroy
  has_many :stamps
  has_many :course_spots
  has_many :model_courses, through: :course_spots

  validates :name, presence: true
  validates :description, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  accepts_nested_attributes_for :spot_detail
end
