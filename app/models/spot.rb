class Spot < ApplicationRecord
  belongs_to :category
  has_many :spot_categories
  has_many :images
  has_many :reviews
  has_many :events
  has_one :spot_detail
end
