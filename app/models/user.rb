class User < ApplicationRecord
    has_many :books
    has_many :favorites
    has_many :favorite_books, through: :favorites, source: :book
    # source: :book => bookモデル？　book_idカラム？
    
    has_many :reviews
    
    # フォローする側（＝フォロワー）の目線
    has_many :following, class_name: "Relationship", foreign_key: "follower_id"
    # class_name ： Relstionshipモデル
    has_many :following_users, through: :following, source: :followed
    # 「user.following_users」でフォローしているユーザー一覧（＝followingをthroughしたユーザーのみ）を取得できる
    # source ： followed_idカラム
    
    # フォローされる側の目線
    has_many :being_followed, class_name: "Relationship", foreign_key: "followed_id"
    # class_name ： Relstionshipモデル
    has_many :followers, through: :being_followed, source: :follower
    # 「user.followers」でフォロワー一覧（＝being_followedをthroughしたユーザーのみ）を取得できる
    # source ： follower_idカラム
    
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
