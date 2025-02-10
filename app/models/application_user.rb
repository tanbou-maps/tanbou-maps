class ApplicationUser < ApplicationRecord
  # 定数の初期化
  CORPORATE_TYPES = YAML.load_file(Rails.root.join('config/corporate_types.yml'))['corporate_types']
  ROLES = %w[user admin moderator].freeze

  # リレーション
  has_many :reviews, dependent: :destroy
  has_many :stamps, dependent: :destroy
  has_many :user_rewards, dependent: :destroy
  has_many :spots, dependent: :destroy
  has_many :model_courses, dependent: :destroy
  has_one_attached :avatar_image # active storage を使用して avatar_image を追加
  has_one_attached :cover_image # active storage を使用して cover_image を追加

  # パスワード管理
  has_secure_password

  # バリデーション
  validates :user_id, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]+\z/, message: '半角英数字とアンダースコアのみ使用できます' }
  validates :nickname, presence: true, format: { with: /\A[\p{Alnum}\p{Han}\p{Hiragana}\p{Katakana}ー―\p{Punct}\s]+\z/, message: '日本語や記号が使用できます' }
  validates :email, presence: true, uniqueness: true
  validates :account_type, presence: true, inclusion: { in: %w[individual corporate] }

  ## 法人ユーザー用
  validates :corporate_type, inclusion: { in: CORPORATE_TYPES }, allow_nil: true, if: -> { account_type == 'corporate' }
  validates :corporate_type, absence: true, if: -> { account_type == 'individual' }


  ## 役割
  validates :role, inclusion: { in: ROLES }

  # 初期値の設定
  after_initialize :set_default_role, if: :new_record?

  # 役割メソッド
  def admin?
    role == 'admin'
  end

  private

  # role のデフォルト値を設定
  def set_default_role
    self.role ||= 'user'
  end
end
