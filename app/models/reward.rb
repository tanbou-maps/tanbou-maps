class Reward < ApplicationRecord
  validates :stamp_count_required, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
