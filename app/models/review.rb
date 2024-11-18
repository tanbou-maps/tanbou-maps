class Review < ApplicationRecord
  belongs_to :spot
  belongs_to :application_user
end
