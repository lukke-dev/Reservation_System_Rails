class Notification < ApplicationRecord
  belongs_to :user

  scope(:unreads, -> { where(read: false) })
end
