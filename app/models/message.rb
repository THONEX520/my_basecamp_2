class Message < ApplicationRecord
  belongs_to :user
  belongs_to :discussion_thread
end
