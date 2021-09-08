class Article < ApplicationRecord
  
  belongs_to :user
  attachment :image
  
  mount_uploader :video, VideoUploader
  
  validates :title, :video, :body, presence: true
  
  has_many :likes, dependent: :destroy
  
  def liked_by?(user)
    likes.where(user_id: user_id).exists?
  end
  # liked_by?メソッドは引用されたユーザーIDがlikesテーブル内に存在(exists?)するかどうかを調べる。
  
  
end
