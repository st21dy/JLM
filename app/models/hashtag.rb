class Hashtag < ApplicationRecord
  validates :hashname, length: { maximum: 99 }
  has_many :article_hashtag_relations
  has_many :articles, through: :article_hashtag_relations
end
