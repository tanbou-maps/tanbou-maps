class Category < ApplicationRecord
  # バリデーション: データの一貫性を保つ
  validates :name, presence: true, uniqueness: true

  # アソシエーション: 他モデルとの関連付け
  has_many :spot_categories
  has_many :spots, through: :spot_categories
end
