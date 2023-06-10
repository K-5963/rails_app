class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user
  
  has_many :reviews
    
  validates :name, presence: true
  validates :description, presence: true
end
