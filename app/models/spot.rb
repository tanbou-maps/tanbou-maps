class Spot < ApplicationRecord
  has_many :spot_details, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  has_and_belongs_to_many :categories
  has_many :spot_tags, dependent: :destroy
end
