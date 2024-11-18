class Category < ApplicationRecord
  has_and_belongs_to_many :spots
  has_many :event_categories
  has_many :events, through: :event_categories
end
