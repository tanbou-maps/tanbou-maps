class Image < ApplicationRecord
  belongs_to :spot

  # If using Active Storage for file uploads
  has_one_attached :file

  # Optional: Add validations
  validates :file, content_type: ['image/png', 'image/jpeg', 'image/jpg'], size: { less_than: 5.megabytes }
end
