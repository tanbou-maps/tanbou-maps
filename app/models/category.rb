class Category < ApplicationRecord
  has_many :categories_spots, dependent: :destroy
  has_many :spots, through: :categories_spots
  has_many :event_categories, dependent: :destroy
  has_many :events, through: :event_categories
end
