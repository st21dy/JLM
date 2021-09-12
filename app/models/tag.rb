class Tag < ApplicationRecord
  
  has_many :tag_maps, dependent: :destroy
  has_many :articles, through: :tag_maps
  # tag_mapsテーブルとの関連付けを行ってから、tag_mapsを通してarticlesテーブルと関連づけている。Tag.articlesとすれば、タグに紐付けられたArticleを取得できる。これは特定のタグ、例えば「1on1」などといったタグを持った投稿を検索したい時などに使える。
  
end
