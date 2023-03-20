class MessageStatus < ApplicationRecord
  belongs_to :message
  belongs_to :user
  belongs_to :room
end
