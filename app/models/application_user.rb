class ApplicationUser < ApplicationRecord
  # 定数の初期化
  CORPORATE_TYPES = YAML.load_file(Rails.root.join('config/corporate_types.yml'))['corporate_types']

  # リレーション
  has_many :reviews, dependent: :destroy
  has_many :stamps, dependent: :destroy
  has_many :user_rewards, dependent: :destroy

  # パスワード管理
  has_secure_password

  # バリデーション
  validates :name, :nickname, :email, :account_type, presence: true
  validates :nickname, :email, uniqueness: true
  validates :account_type, inclusion: { in: %w[individual corporate] }
  validates :corporate_type, inclusion: { in: CORPORATE_TYPES }, allow_nil: true, if: -> { account_type == 'corporate' }
  validates :corporate_type, absence: true, if: -> { account_type == 'individual' }
  validates :corporate_type, presence: true, if: -> { corporate? }

  # 法人ユーザー判定
  def corporate?
    account_type == 'corporate'
  end

  # ユーザ役職の定義
  ROLES = %w[user admin moderator].freeze
  validates :role, inclusion: { in: ROLES }

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def user?
    role == 'user'
  end
end
