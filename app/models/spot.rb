class Spot < ApplicationRecord
  has_one :spot_detail, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  has_and_belongs_to_many :categories
  has_many :spot_tags, dependent: :destroy

  # allow nested attributes for spot_details
  accepts_nested_attributes_for :spot_detail, allow_destroy: true

  # Optional: Add validations
  validates :name, presence: true
  validates :latitude, :longitude, presence: true
end
