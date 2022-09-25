class Notification < ApplicationRecord
  belongs_to :user

  scope(:unreads, -> { where(read: false).order(created_at: :desc) })
end
