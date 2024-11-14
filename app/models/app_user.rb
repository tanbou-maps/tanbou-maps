class AppUser < ApplicationRecord
  # バリデーション: データの一貫性を保つ
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :account_status, inclusion: { in: %w[active inactive suspended] }

  # アソシエーション: 他のモデルとの関連付け
  has_many :stamps
  has_many :reviews
  has_many :user_rewards
end
