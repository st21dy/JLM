class Article < ApplicationRecord
  
  belongs_to :user
  attachment :image
  
  mount_uploader :video, VideoUploader
  
  validates :title, :video, :body, presence: true
  
  has_many :likes, dependent: :destroy
  has_many :article_comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  # liked_by?メソッドは引用されたユーザーIDがlikesテーブル内に存在(exists?)するかどうかを調べる。
  
  
  def save_tag(save_tags)
    # 現在のユーザーの持っているskillを引っ張ってきている
    tags
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 今articleが持っているタグと今回保存されたものの差をすでにあるタグとする。古いタグは消す。
    old_tags = current_tags - save_tags
    # 今回保存されたものと現在の差を新しいタグとする。新しいタグは保存
    new_tags = save_tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      article_tag = Tag.find_or_create_by(tag_name:new_name)
      # 配列に保存
      self.tags << article_tag
    end
  end
  
  
end
