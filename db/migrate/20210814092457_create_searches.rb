class CreateSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :searches do |t|
      t.string :title
      t.string :preferred_district
      t.string :city
      t.integer :max_price
      t.integer :min_size
      t.integer :room
      t.string :category
      t.string :frequency
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
