class CreateArticleHashtagRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :article_hashtag_relations do |t|

      t.integer :article_id
      t.integer :hashtag_id
      t.timestamps
    end
  end
end
