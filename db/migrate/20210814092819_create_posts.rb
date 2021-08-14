class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :address
      t.integer :price
      t.integer :size
      t.string :post_url
      t.string :image_url
      t.integer :room
      t.string :category
      t.text :description
      t.date :date_posted
      t.string :company

      t.timestamps
    end
  end
end
