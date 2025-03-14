class DiscussionThread < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
end
