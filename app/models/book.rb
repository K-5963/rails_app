class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user
  
  has_many :reviews
  
  def reviewed_by?(user)
    Review.find_by(user_id: user.id, book_id: self.id)
  end
  
  def average_rate
    reviews.average(:rate).round(1)
  end
  
  def star
    rate = reviews.average(:rate).round(1)
    return "⭐️" if rate >= 1.0 && rate <= 1.4
    return "⭐⭐️️" if rate >= 1.5 && rate <= 2.4
    return "⭐️⭐⭐️" if rate >= 2.5 && rate <= 3.4
    return "⭐️⭐⭐️⭐️" if rate >= 3.5 && rate <= 4.4
    return "⭐️⭐⭐️⭐⭐️" if rate >= 4.5 && rate <= 5.0
  end
    
  validates :name, presence: true
  validates :description, presence: true
end
