class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user
  
  has_many :reviews
  
  def reviewed_by?(user)
    Review.find_by(user_id: user.id, book_id: self.id)
  end
    
  validates :name, presence: true
  validates :description, presence: true
end
