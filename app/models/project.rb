class Project < ApplicationRecord
  belongs_to :user
  has_many_attached :files
  has_many :attachments, dependent: :destroy
  has_many :discussion_threads, dependent: :destroy
  
  has_and_belongs_to_many :users, join_table: :projects_users  
end
