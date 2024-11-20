class ModelCourseImage < ApplicationRecord
  belongs_to :model_course

  validates :url, presence: true
end
