class User < ApplicationRecord
    has_many :books
    has_many :favorites
    has_many :favorite_books, through: :favorites, source: :book
    
    has_many :reviews
    
    has_many :following, class_name: "Relationship", foreign_key: "follower_id"
    has_many :following_users, through: :following, source: :followed
    
    has_many :being_followed, class_name: "Relationship", foreign_key: "followed_id"
    has_many :followers, through: :being_followed, source: :follower
    
    def follow(user_id)
      following.create!(followed_id: user_id)
    end
    
    def unfollow(user_id)
      following.find_by(followed_id: user_id).destroy!
    end
    
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 200 }, uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
