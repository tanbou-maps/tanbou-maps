class SpotDetail < ApplicationRecord
  belongs_to :spot

  validates :hours_of_operation, presence: true
  validates :access_info, presence: true
  validates :contact_info, presence: true
  validates :website_url, presence: true
  validates :recommended_season, presence: true
  validates :entry_fee, presence: true
end
