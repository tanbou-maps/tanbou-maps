class SpotDetail < ApplicationRecord
  belongs_to :spot

  validates :hours_of_operation, presence: true, allow_blank: true
  validates :access_info, presence: true, allow_blank: true
  validates :contact_info, presence: true, allow_blank: true
  validates :website_url, presence: true, allow_blank: true
  validates :recommended_season, presence: true, allow_blank: true
  validates :entry_fee, presence: true, allow_blank: true
end
