class Message < ApplicationRecord
  belongs_to :discussion_thread
  belongs_to :user

  validates :content, presence: true
end
