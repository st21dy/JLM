class Article < ApplicationRecord
  
  belongs_to :user
  attachment :image
  
  mount_uploader :video, VideoUploader
  
  validates :title, :video, :body, presence: true
  
  has_many :likes, dependent: :destroy
  has_many :article_comments, dependent: :destroy
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  # liked_by?メソッドは引用されたユーザーIDがlikesテーブル内に存在(exists?)するかどうかを調べる。
  
  
  def self.search(keyword)
    if keyword
      Article.where(['title LIKE ? OR body LIKE ? OR tag LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    else
      Article.all
    end
      
  end
  
end
