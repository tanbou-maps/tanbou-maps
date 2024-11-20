class CourseSpot < ApplicationRecord
  belongs_to :model_course
  belongs_to :spot

  validates :order_number, presence: true, numericality: { only_integer: true }
end
