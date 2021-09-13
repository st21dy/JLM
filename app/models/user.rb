class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :articles, dependent: :destroy
  attachment :icon
  
  has_many :article_comments, dependent: :destroy
  
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  # throughオプションによって、tag_mapsテーブルを通してtagsテーブルとの関連付けを行っている。こうすることで、Article.tagsとすればArticleに紐付けられたTagの取得が可能になる。これは投稿詳細画面などでその投稿に付けられているタグを取得して表示させるなどの際に使える。
  
  validates :body, presence: false, length: { maximum: 50 } 
  # 自己紹介の最高文字数は50文字
  
  has_many :likes, dependent: :destroy
  # dependent: :destroyでデータが削除された場合関連して削除されるよう設定(Userのデータが削除された時、そのUserが投稿したいいねデータも一緒に削除される)
  
  has_many :follower, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  
  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
  
  # 退会機能
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  
  def self.search(keyword)
    if keyword
      User.where(['name LIKE ?', "%#{keyword}%"])
    else
      User.all
    end
      
  end
  
  
end
