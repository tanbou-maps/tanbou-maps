# Terminal commands to run:
# bin/rails active_storage:install
# bin/rails db:migrate

# app/models/spot.rb
class Spot < ApplicationRecord
  has_one :spot_detail, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  has_and_belongs_to_many :categories
  has_many :spot_tags, dependent: :destroy
  has_many_attached :photos # Add this line

  # allow nested attributes for spot_details
  accepts_nested_attributes_for :spot_detail, allow_destroy: true

  # Validations
  validates :name, presence: true
  validates :latitude, :longitude, presence: true

  # Add photo validations
  validates :photos, content_type: ['image/png', 'image/jpeg', 'image/jpg'],
                     size: { less_than: 5.megabytes },
                     limit: { max: 10 }
end
