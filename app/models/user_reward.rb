class UserReward < ApplicationRecord
  belongs_to :application_user
  belongs_to :reward
end
