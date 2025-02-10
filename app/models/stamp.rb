class Stamp < ApplicationRecord
  belongs_to :application_user
  belongs_to :spot

  # スタンプ取得状況を管理
  STATUSES = %w[pending collected expired].freeze
  validates :status, inclusion: { in: STATUSES }
end
