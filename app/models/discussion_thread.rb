class DiscussionThread < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :messages, dependent: :destroy


  validates :title, presence: true
  #validates :description, presence: true
end
