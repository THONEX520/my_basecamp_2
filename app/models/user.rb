class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  has_many :discussion_threads, dependent: :destroy
end