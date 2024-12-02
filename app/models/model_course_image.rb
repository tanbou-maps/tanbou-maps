class ModelCourseImage < ApplicationRecord
  belongs_to :model_course

  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
  validates :description, length: { maximum: 200 }, allow_blank: true
end
