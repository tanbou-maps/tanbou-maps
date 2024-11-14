class Stamp < ApplicationRecord
  belongs_to :app_user, foreign_key: :user_id
  belongs_to :spot
  validates :method, presence: true
end
