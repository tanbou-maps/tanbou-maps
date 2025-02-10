class Event < ApplicationRecord
  belongs_to :spot
  has_many :event_categories
  has_many :categories, through: :event_categories

  # 時刻の整合性をチェック
  validates :end_time, comparison: { greater_than: :start_time }, if: -> { start_time.present? && end_time.present? }
end
