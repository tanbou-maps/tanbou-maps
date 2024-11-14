class UserReward < ApplicationRecord
  belongs_to :app_user, foreign_key: :user_id
  belongs_to :reward
end
