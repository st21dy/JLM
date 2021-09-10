class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :articles, dependent: :destroy
  attachment :icon
  
  validates :body, presence: false, length: { maximum: 50 } 
  # 自己紹介の最高文字数は50文字
  
  has_many :likes, dependent: :destroy
  # dependent: :destroyでデータが削除された場合関連して削除されるよう設定(Userのデータが削除された時、そのUserが投稿したいいねデータも一緒に削除される)
  
  
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_follows, source: :follower
  # 被フォロー関係を通じて参照→followed_idをフォローしている人

  has_many :follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  # 【class_name: "Follow"】は省略可能
  has_many :followings, through: :follows, source: :followed
  # 与フォロー関係を通じて参照→follower_idをフォローしている人
  
  def follow(user_id)
    follows.create(followed_id: user_id)
  end
  def unfollow(user_id)
    follows.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end
  
end
