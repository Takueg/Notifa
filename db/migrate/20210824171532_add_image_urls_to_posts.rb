class AddImageUrlsToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :image_urls, :string, array: true, default: []
    remove_column :posts, :image_url
  end
end
