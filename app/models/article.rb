class Article < ApplicationRecord
  belongs_to :user
  attachment :image

  mount_uploader :video, VideoUploader

  validates :title, :video, :body, :caption, presence: true
  validates :caption, format: { without: /＃/, message: ' # は半角で入力してください' }
  validates :caption, format: { with: /#/, message: ' # を先頭に付けてください'}

  has_many :likes, dependent: :destroy
  has_many :article_comments, dependent: :destroy

  has_many :article_hashtag_relations
  has_many :hashtags, through: :article_hashtag_relations

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  # liked_by?メソッドは引用されたユーザーIDがlikesテーブル内に存在(exists?)するかどうかを調べる。

  def self.search(keyword)
    if keyword
      Article.where(['title LIKE ? OR caption LIKE ?', "%#{keyword}%", "%#{keyword}%"])
    else
      Article.all
    end
  end

  # DBへのコミット直前に実施する
  after_create do
    article = Article.find_by(id: id)
    hashtags = caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    article.hashtags = []
    hashtags.uniq.map do |hashtag|
      # ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      article.hashtags << tag
    end
  end

  before_update do
    article = Article.find_by(id: id)
    article.hashtags.clear
    hashtags = caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      article.hashtags << tag
    end
  end
end
