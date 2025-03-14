class Project < ApplicationRecord
  belongs_to :user
  has_many_attached :files
  has_many :attachments, dependent: :destroy
end
