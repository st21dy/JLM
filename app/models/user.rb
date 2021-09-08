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
  
  
  
end
