class Project < ApplicationRecord
    belongs_to :user
    has_many :attachments, dependent: :destroy
    has_many :project_threads, dependent: :destroy
  end
  