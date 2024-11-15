class AppUser < ApplicationRecord
  # バリデーション: データの一貫性を保つ
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :account_status, inclusion: { in: %w[active inactive suspended] }
  validates :account_type, inclusion: { in: %w[individual corporate], message: "must be 'individual' or 'corporate'" }
  validates :corporate_type, presence: true, if: -> { account_type == "corporate" }
  validates :corporate_type, inclusion: { in: CORPORATE_TYPES }, allow_nil: true
  validate :corporate_type_must_be_nil_for_individual

  # 法人の種類のリスト
  CORPORATE_TYPES = [
    "株式会社",
    "有限会社",
    "合同会社",
    "合資会社",
    "一般社団法人",
    "一般財団法人",
    "公益社団法人",
    "公益財団法人",
    "独立行政法人",
    "国立大学法人",
    "地方独立行政法人",
    "公立大学法人",
    "学校法人",
    "宗教法人",
    "医療法人",
    "社会福祉法人"
  ].freeze

  # アソシエーション: 他のモデルとの関連付け
  has_many :stamps
  has_many :reviews
  has_many :user_rewards

  private

  # 一般ユーザの場合、法人種類はnilでなければならない
  def corporate_type_must_be_nil_for_individual
    if account_type == "individual" && corporate_type.present?
      errors.add(:corporate_type, "must be blank for individual accounts")
    end
  end
end
