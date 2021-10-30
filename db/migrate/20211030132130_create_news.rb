class CreateNews < ActiveRecord::Migration[5.2]
  def change
    create_table :news do |t|
      t.text :title
      t.text :score
      t.string :image_id
      t.text :league
      t.integer :admin_id

      t.timestamps
    end
  end
end
