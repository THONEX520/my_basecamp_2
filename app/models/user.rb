class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :discussion_threads, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_and_belongs_to_many :projects, join_table: :projects_users 

  def admin?
    has_role?(:admin)  
  end
end
