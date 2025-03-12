class Discussion < ApplicationRecord
  belongs_to :project_thread
  belongs_to :user
end
