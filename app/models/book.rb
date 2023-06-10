class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user
  
  has_many :reviews
  #has_many :comments, through: :reviews, source: :comment
    
  validates :name, presence: true
  validates :description, presence: true
end
